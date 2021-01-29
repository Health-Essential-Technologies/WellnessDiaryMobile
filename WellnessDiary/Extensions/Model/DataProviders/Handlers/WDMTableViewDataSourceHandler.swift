//
//  WDMTableViewDataSourceHandler.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMTableViewDataSourceHandler: NSObject {
    
    // MARK:  - Properties
    
    var tableViewInfoProvider: WDMTableViewInfoProvider
    
    // MARK: - Initializers
    
    init(tableViewInfoProvider: WDMTableViewInfoProvider) {
        self.tableViewInfoProvider = tableViewInfoProvider
    }
    
}
