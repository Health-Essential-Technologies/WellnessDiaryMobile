//
//  TableViewDataSourceHandler.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class TableViewDataSourceHandler: NSObject {
    
    // MARK:  - Properties
    
    var tableViewInfoProvider: TableViewInfoProvider
    
    // MARK: - Initializers
    
    init(tableViewInfoProvider: TableViewInfoProvider) {
        self.tableViewInfoProvider = tableViewInfoProvider
    }
    
}
