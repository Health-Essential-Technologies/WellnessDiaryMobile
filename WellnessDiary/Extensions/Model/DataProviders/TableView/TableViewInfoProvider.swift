//
//  TableViewInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class TableViewInfoProvider: NSObject {
    
    // MARK: - Properties
    
    var sectionItems = [TableViewSectionItem]()
    
    // MARK: - Initializers
    
    init(withSectionItems sectionItems: [TableViewSectionItem] = []) {
        self.sectionItems = sectionItems
    }
    
    // MARK: - Methods
    
    func getNumberOfSections() -> Int {
        return sectionItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItems[safe: section]?.sectionRowItems.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionItems[safe: section]?.headerTitle
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionItems[safe: section]?.footerTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionItems[safe: indexPath.section]?.sectionRowItems[safe: indexPath.row]?.cellHeight ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellItem = sectionItems[safe: indexPath.section]?.sectionRowItems[safe: indexPath.row] else { return DefaultTableViewCell() }
        
        var cell: SimpleTableViewCell
        
        switch cellItem.cellType {
        
        case is DatePickerTableViewCell.Type:
            cell = getDatePickerTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
            
        case is PickerTableViewCell.Type:
            cell = getPickerTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
            
        case is DefaultTableViewCell.Type:
            cell = getDefaultTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
            
        case is SingleButtonTableViewCell.Type:
            cell = getSingleButtonTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
            
        case is HealthEntryTableViewCell.Type:
            cell = getHealthEntryTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
            
        default:
            cell = getDefaultTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
        }
        
        return cell
    }
    
    private func getDatePickerTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> SimpleTableViewCell {
        
        let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! DatePickerTableViewCell
        castedCell.cellInfoProvider = cellItem.cellInfoProvider
        
        return castedCell
    }
    
    private func getPickerTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> SimpleTableViewCell {
        
        let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! PickerTableViewCell
        
        let pickerViewInfoProvider = cellItem.cellInfoProvider as? PickerViewInfoProvider
        let dataSourceHandler = PickerViewDataSourceHandler()
        dataSourceHandler.pickerViewInfoProvider = pickerViewInfoProvider
        castedCell.cellDataSource = dataSourceHandler
        
        castedCell.pickerView.dataSource = dataSourceHandler
        // pickerView.delegate must be set by a subclass of this class.
        
        castedCell.cellInfoProvider = pickerViewInfoProvider
        
        return castedCell
    }
    
    private func getSingleButtonTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> SimpleTableViewCell {
        let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! SingleButtonTableViewCell
        castedCell.cellInfoProvider = cellItem.cellInfoProvider
        
        if let castedTableView = tableView as? SimpleTableView {
            castedCell.tableViewDelegate = castedTableView
        }
        
        return castedCell
    }
    
    private func getHealthEntryTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> SimpleTableViewCell {
        let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! HealthEntryTableViewCell
        castedCell.cellInfoProvider = cellItem.cellInfoProvider
        return castedCell
    }
    
    private func getDefaultTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> SimpleTableViewCell  {
        let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! SimpleTableViewCell
        return castedCell
    }
}
