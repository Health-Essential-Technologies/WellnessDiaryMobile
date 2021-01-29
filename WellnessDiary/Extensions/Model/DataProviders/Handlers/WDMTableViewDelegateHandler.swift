//
//  WDMTableViewDelegateHandler.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMTableViewDelegateHandler: NSObject {
    
    // MARK:  - Properties
    
    private var tableViewInfoHandler: WDMTableViewInfoProvider
    
    // MARK: - Initializers
    
    init(tableViewInfoHandler: WDMTableViewInfoProvider) {
        self.tableViewInfoHandler = tableViewInfoHandler
    }
    
}
