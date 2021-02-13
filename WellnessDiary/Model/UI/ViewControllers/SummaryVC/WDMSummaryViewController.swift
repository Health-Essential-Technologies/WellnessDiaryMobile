//
//  WDMSummaryViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 2/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSummaryViewController: WDMSimpleViewController {

  // MARK: - Properties
  
  var previousVC = WDMSummaryContainerViewController(storeManager: CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager)
  
  // MARK: - Initializers
  
    override func viewDidLoad() {
        super.viewDidLoad()
      NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name(rawValue: "updated"), object: nil)
      add(previousVC)
    }
  
  @objc func update() {
    previousVC.remove()
    previousVC = WDMSummaryContainerViewController(storeManager: CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager)
    add(previousVC)
  }

}
