//
//  TableViewSectionRowItem.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

public struct TableViewSectionRowItem {
    
    // MARK: - Properties
    
    var cellInfoProvider = WDMCellInfoProvider()
    var cellType: WDMSimpleTableViewCell.Type = WDMDefaultTableViewCell.self
    var cellHeight: CGFloat = UITableView.automaticDimension
    
    var cellIdentifier: String {
        return NSStringFromClass(cellType)
    }
    
    // MARK: - Initializer
    init(WithtableView tableView: UITableView, cellInfoProvider: WDMCellInfoProvider, cellType: WDMSimpleTableViewCell.Type, cellHeight: CGFloat = UITableView.automaticDimension) {
        self.cellInfoProvider = cellInfoProvider
        self.cellType =  cellType
        self.cellHeight = cellHeight
        
        tableView.register(cellClass: cellType)
    }
}
