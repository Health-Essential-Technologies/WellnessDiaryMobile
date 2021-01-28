//
//  TableViewDelegateHandler.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class TableViewDelegateHandler: NSObject {
    
    // MARK:  - Properties
    
    private var tableViewInfoHandler: TableViewInfoProvider
    
    // MARK: - Initializers
    
    init(tableViewInfoHandler: TableViewInfoProvider) {
        self.tableViewInfoHandler = tableViewInfoHandler
    }
    
}
