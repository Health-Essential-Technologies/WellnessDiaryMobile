//
//  TableViewSectionRowItem.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

struct TableViewSectionRowItem {
    
    // MARK: - Properties
    
    var cellInfoProvider = CellInfoProvider()
    var cellType: SimpleTableViewCell.Type = DefaultTableViewCell.self
    var cellHeight: CGFloat = UITableView.automaticDimension
    
    var cellIdentifier: String {
        return NSStringFromClass(cellType)
    }
    
    // MARK: - Initializer
    init(WithtableView tableView: UITableView, cellInfoProvider: CellInfoProvider, cellType: SimpleTableViewCell.Type, cellHeight: CGFloat = UITableView.automaticDimension) {
        self.cellInfoProvider = cellInfoProvider
        self.cellType =  cellType
        self.cellHeight = cellHeight
        
        tableView.register(cellClass: cellType)
    }
}
