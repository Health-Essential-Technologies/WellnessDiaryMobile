//
//  WDMTableViewInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMTableViewInfoProvider: NSObject {
  
  // MARK: - Properties
  
  weak var presenterViewController: WDMSimpleViewController?
  var sectionItems = [TableViewSectionItem]()
  
  // MARK: - Initializers
  
  init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil) {
    self.sectionItems = sectionItems
    self.presenterViewController = presenterViewController
  }
  
  // MARK: - Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
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
    
    guard let cellItem = sectionItems[safe: indexPath.section]?.sectionRowItems[safe: indexPath.row] else { return WDMDefaultTableViewCell() }
    
    var cell: WDMSimpleTableViewCell
    
    switch cellItem.cellType {
    
    case is WDMDatePickerTableViewCell.Type:
      cell = getDatePickerTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMPickerTableViewCell.Type:
      cell = getPickerTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMDefaultTableViewCell.Type:
      cell = getDefaultTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMSingleButtonTableViewCell.Type:
      cell = getSingleButtonTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMLabelTextfieldTableViewCell.Type:
      cell = getLabelTextfieldTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMLabelSwitchTableViewCell.Type:
      cell = getLabelSwitchTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMTaskDetailsTableViewCell.Type:
      cell = getTaskDetailsTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    case is WDMSummaryTableViewCell.Type:
      cell = getSummaryTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
      
    default:
      cell = getDefaultTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    }
    
    cell.accessoryType = cellItem.cellInfoProvider.cellAccessoryType
    return cell
  }
  
  func getDatePickerTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMDatePickerTableViewCell {
    
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMDatePickerTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    
    return castedCell
  }
  
  func getPickerTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSimpleTableViewCell {
    
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMPickerTableViewCell
    
    let pickerViewInfoProvider = cellItem.cellInfoProvider as? WDMPickerViewInfoProvider
    let dataSourceHandler = WDMPickerViewDataSourceHandler()
    dataSourceHandler.pickerViewInfoProvider = pickerViewInfoProvider
    castedCell.cellDataSource = dataSourceHandler
    
    castedCell.pickerView.dataSource = dataSourceHandler
    // pickerView.delegate must be set by a subclass of this class.
    
    castedCell.cellInfoProvider = pickerViewInfoProvider
    
    return castedCell
  }
  
  func getSingleButtonTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSingleButtonTableViewCell {
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMSingleButtonTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    
    if let castedTableView = tableView as? WDMSimpleTableView {
      castedCell.tableViewDelegate = castedTableView
    }
    
    return castedCell
  }
  
  func getLabelTextfieldTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMLabelTextfieldTableViewCell {
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMLabelTextfieldTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    return castedCell
  }
  
  func getDefaultTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSimpleTableViewCell  {
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMDefaultTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    castedCell.selectionStyle = .default
    return castedCell
  }
  
  func getLabelSwitchTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMLabelSwitchTableViewCell {
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMLabelSwitchTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    return castedCell
  }
  
  
  func getTaskDetailsTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMTaskDetailsTableViewCell {
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMTaskDetailsTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    return castedCell
  }
  
  func getSummaryTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSummaryTableViewCell {
    let castedCell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellIdentifier, for: indexPath) as! WDMSummaryTableViewCell
    castedCell.cellInfoProvider = cellItem.cellInfoProvider
    return castedCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
