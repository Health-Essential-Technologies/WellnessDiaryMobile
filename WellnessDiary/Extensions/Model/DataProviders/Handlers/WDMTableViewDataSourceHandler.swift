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

extension WDMTableViewDataSourceHandler: UITableViewDataSource {
  
  // MARK: - Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewInfoProvider.numberOfSections(in: tableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewInfoProvider.tableView(tableView, numberOfRowsInSection: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableViewInfoProvider.tableView(tableView, cellForRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return tableViewInfoProvider.tableView(tableView, titleForHeaderInSection: section)
  }
  
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return tableViewInfoProvider.tableView(tableView, titleForFooterInSection: section)
  }
  
}
