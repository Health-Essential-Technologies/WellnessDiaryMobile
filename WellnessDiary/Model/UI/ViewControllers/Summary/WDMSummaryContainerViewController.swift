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
  
  var listNavigationBarItem: WDMSimpleBarButtomItem = {
    let item = WDMSimpleBarButtomItem(image: Icons.listIcon.image, style: .plain, target: self, action: #selector(listNavBarBtnTapped(_:)))
    return item
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
  override func initialSetup() {
    super.initialSetup()
    
    self.parent?.navigationItem.rightBarButtonItems = [
      WDMSimpleBarButtomItem(barButtonSystemItem: .add, target: self, action: #selector(addNavBarBtnTapped(_:)))
    ]
    
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
    
    let entityQuery = OCKTaskQuery(for: Date())
    CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager.store.fetchAnyTasks(query: entityQuery, callbackQueue: .main) {
      results in
      guard let task = try? results.get() else { return }
      
      CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager.store.deleteAnyTask(task.first!, callbackQueue: .main) { (results) in
        
      }
    }
    

  }
  
  @objc private func addNavBarBtnTapped(_ sender: Any) {
    self.parent?.navigationController?.pushViewController(WDMSummaryAddTaskViewController(), animated: true)
  }

  private func shouldDisplayListItemBar() {
    if true {
      navigationItem.rightBarButtonItems?.append(listNavigationBarItem)
    } else {
      navigationItem.rightBarButtonItems?.removeLast()
    }
  }
  
}
