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

extension WDMTableViewDelegateHandler: UITableViewDelegate {
  
  // MARK: - Methods
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableViewInfoHandler.tableView(tableView, heightForRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableViewInfoHandler.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return tableViewInfoHandler.tableView(tableView, viewForFooterInSection: section)
  }
}
