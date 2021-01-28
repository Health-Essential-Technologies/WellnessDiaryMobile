//
//  SummaryDetailViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import UIKit
import CareKit

class SummaryDetailViewController: OCKDailyPageViewController {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
  }
  
  override func dailyPageViewController(_ dailyPageViewController: OCKDailyPageViewController, prepare listViewController: OCKListViewController, for date: Date) {
    
    let identifiers = TaskIdentifier.allCases.map { $0.rawValue }
    var query = OCKTaskQuery(for: date)
    query.ids = identifiers
    query.excludesTasksWithNoEvents = true
    
    storeManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { result in
      guard let task = try? result.get() else { return }
      
      task.forEach { task in
        switch task.id {
        
        case TaskIdentifier.bloodSugarTest.rawValue:
          let bloodSugarCard = OCKInstructionsTaskViewController(taskID: task.id, eventQuery: .init(for: date), storeManager: self.storeManager)
//          let bloodSugarCard = OCKButtonLogTaskViewController(taskID: task.id, eventQuery: .init(for: date), storeManager: self.storeManager)
          bloodSugarCard.view.tintColor = Colors.mainColor.color
          listViewController.appendViewController(bloodSugarCard, animated: true)

//
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
          break
          
        default:
          break
        }
      }
      
    }
  }
}
