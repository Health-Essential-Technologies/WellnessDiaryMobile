//
//  WDMSummaryAddTaskViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import Foundation

class WDMSummaryAddTaskViewController: WDMSimpleViewController {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    navigationItem.title = localLoc("ADD_TASK")
  }
  
}