//
//  WDMTaskDetailsViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMTaskDetailsViewController: WDMSimpleTableViewController {
  
  // MARK: Propertie
  
  var tasks = [WDMTask]()
  
  // MARK: Initializers
  
  init(with tasks: [WDMTask]) {
    self.tasks = tasks
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  // MARK: Methods
  
  override func initialSetup() {
    
    navigationItem.title = "TASKS_LIST".localize()
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    tableView.isScrollEnabled = false
    
    infoProvider = createInfoProvider()
    
    super.initialSetup()
    
  NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .taskDeleted, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .taskUpdated, object: nil)
  }
  
  override func createInfoProvider() -> WDMTableViewInfoProvider {
    
    var sections = [TableViewSectionItem]()
    
    tasks.forEach {
      let provider = WDMTaskDetailsCellInfoProvider(with: $0)
      provider.cellAccessoryType = .disclosureIndicator
      sections.append(TableViewSectionItem(headerTitle: "",
                                         footerTitle: "",
                                         sectionRowItems: [TableViewSectionRowItem(WithtableView: tableView,
                                                                                  cellInfoProvider: provider,
                                                                                  cellType: WDMTaskDetailsTableViewCell.self)]))
    }
    
    return WDMTaskDetailsInfoProvider(withSectionItems: sections, presenterViewController: self, tasks: tasks)
  }
  
  @objc private func notificationReceived(_ notification: Notification) {
    if notification.name == .taskDeleted {
      if let task = notification.object as? WDMTask {
        if let taskIndex = tasks.firstIndex(of: task) {
          tasks.remove(at: taskIndex)
        }
      }
      
      if tasks.count == 0 {
        navigationController?.popToRootViewController(animated: true)
      }

    } else if notification.name == .taskUpdated {
      if let task = notification.object as? WDMTask {
        if let taskIndex = tasks.firstIndex(of: task) {
          tasks[taskIndex] = task
        }
      }
    }
    
    infoProvider = createInfoProvider()
    tableView.reloadData()
  }
  
}
