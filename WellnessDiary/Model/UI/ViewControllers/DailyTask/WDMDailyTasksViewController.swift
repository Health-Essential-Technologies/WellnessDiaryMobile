//
//  WDMDailyTasksViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 2/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMDailyTasksViewController: WDMSimpleViewController {

  // MARK: - Properties
  
  var previousVC = WDMDailyTasksContainerViewController(storeManager: CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager)
  
  // MARK: - Initializers
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  override func initialSetup() {
    super.initialSetup()
    add(previousVC)
    NotificationCenter.default.addObserver(self, selector: #selector(update), name: .newTaskAdded, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(update), name: .taskDeleted, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(update), name: .taskUpdated, object: nil)
  }
  
  @objc func update() {
    previousVC.remove()
    previousVC = WDMDailyTasksContainerViewController(storeManager: CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager)
    add(previousVC)
  }

}
