//
//  WDMSummaryTableViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 3/4/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSummaryTableViewController: WDMSimpleTableViewController {

  // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // MARK: Methods
  
  override func initialSetup() {
    super.initialSetup()
    title = "SUMMARY".localize()
  }

}
