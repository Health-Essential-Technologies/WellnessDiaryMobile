//
//  WDMTaskDetailsInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMTaskDetailsInfoProvider: WDMTableViewInfoProvider {
  
  // MARK: Properties
  
  private var tasks = [WDMTask]()
  
  // MARK: Initializers
  
  public init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil, tasks: [WDMTask]) {
    self.tasks = tasks
    super.init(withSectionItems: sectionItems, presenterViewController: presenterViewController)
  }

  // MARK: Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenterViewController?.navigationController?.pushViewController(WDMSummaryAddTaskViewController(with: tasks[indexPath.section], editMode: true), animated: true)
    super.tableView(tableView, didSelectRowAt: indexPath)
  }
  
}
