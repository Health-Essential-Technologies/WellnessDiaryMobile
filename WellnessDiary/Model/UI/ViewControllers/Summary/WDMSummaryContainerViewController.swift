//
//  WDMSummaryContainerViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import UIKit
import CareKit

class WDMSummaryContainerViewController: OCKDailyPageViewController {
  
  // MARK: - Properties
  
  var listNavigationBarItem: WDMSimpleBarButtomItem!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
  override func initialSetup() {
    super.initialSetup()
    listNavigationBarItem = WDMSimpleBarButtomItem(image: Icons.listIcon.image, style: .plain, target: self, action: #selector(listNavBarBtnTapped(_:)))
    self.parent?.navigationItem.rightBarButtonItems = [
      WDMSimpleBarButtomItem(barButtonSystemItem: .add, target: self, action: #selector(addNavBarBtnTapped(_:))),
      listNavigationBarItem
    ]
    
    shouldDisplayListItemBar()
    
  }
  
  
  override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController, prepare listViewController: OCKListViewController, for date: Date) {
    
    var query = OCKTaskQuery(for: date)
    query.excludesTasksWithNoEvents = true
    
    storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { [unowned self] result in
      guard let task = try? result.get() else { return }
      
      task.forEach { task in
        switch task.id {
          
//          let chartView = OCKCartesianChartView(type: .line)
//
//          chartView.headerView.titleLabel.text = "Doxylamine"
//
//
//          var series = OCKDataSeries(values: [1,2,3,1], title: "Doxylamine", size: 2, color: .red)
//          chartView.graphView.dataSeries = [
//            series,
//          ]
//
//          listViewController.appendView(chartView, animated: true)
          
        default:
          
          let eventQuery = OCKEventQuery(for: date)
          self.storeManager.store.fetchAnyEvents(taskID: task.id, query: eventQuery, callbackQueue: .main) { [unowned self] result in
            guard let events = try? result.get() else { return }
            
            if events.count > 1 {
              let taskController = OCKGridTaskViewController(taskID: task.id, eventQuery: .init(for: date), storeManager: self.storeManager)
              taskController.view.tintColor = Colors.mainColor.color
              listViewController.appendViewController(taskController, animated: true)
            } else {
              let taskController = OCKSimpleTaskViewController(taskID: task.id, eventQuery: .init(for: date), storeManager: self.storeManager)
              taskController.view.tintColor = Colors.mainColor.color
              listViewController.appendViewController(taskController, animated: true)
            }
          }
          
        }
      }
    }
  }
  
  // MARK: - Methods
  
  @objc private func listNavBarBtnTapped(_ sender: Any) {
    
    let store = storeManager.store as! WDMStore
    let ids = store.fetchAllTaskIDs()
    
    var query = OCKTaskQuery()
    query.excludesTasksWithNoEvents = true
    ids.forEach {
      query.ids.append($0.uniqueIdentifier)
    }
    
    var castedTasks = [WDMTask]()
    
    storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { results in
      let result = try? results.get()
      guard let tasks = result as? [OCKTask] else { return }
      for index in 0..<tasks.count {
        // Because carekit produces a new task with the same identifier when a task is updated
        // Need to check for repeats and keep assigning until find the last one (the most recent updated one).
        let castedTask = WDMTask(with: tasks[index])
        if castedTasks.contains(castedTask) {
          if let duplicateObjectIndex = castedTasks.firstIndex(of: castedTask) {
            castedTasks[duplicateObjectIndex] = castedTask
            continue
          }
        }
        castedTasks.append(castedTask)
        
      }
      
      self.parent?.navigationController?.pushViewController(WDMTaskDetailsViewController(with: castedTasks), animated: true)
    }
    
  }
  
  @objc private func addNavBarBtnTapped(_ sender: Any) {
    self.parent?.navigationController?.pushViewController(WDMSummaryAddTaskViewController(with: WDMTask(Date())), animated: true)
  }

  private func shouldDisplayListItemBar() {
    guard let parentRightBarItems = parent?.navigationItem.rightBarButtonItems else {
      return
    }
    
    let store = storeManager.store as! WDMStore
    let ids = store.fetchAllTaskIDs()
    
    if ids.count > 0 {
      if !parentRightBarItems.contains(listNavigationBarItem) {
        self.parent?.navigationItem.rightBarButtonItems?.append(listNavigationBarItem)
      }
    } else {
      if parentRightBarItems.contains(listNavigationBarItem) {
        self.parent?.navigationItem.rightBarButtonItems?.removeLast()
      }
    }
    
  }
  
}
