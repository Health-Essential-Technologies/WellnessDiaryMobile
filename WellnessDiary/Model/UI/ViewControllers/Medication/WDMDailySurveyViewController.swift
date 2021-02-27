//
//  WDMDailySurveyViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit
import CareKit

class WDMDailySurveyViewController: WDMSimpleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func initialSetup() {
    super.initialSetup()
    navigationItem.title = "DAILY_SURVEY".localize()
    navigationItem.rightBarButtonItem = WDMSimpleBarButtomItem(systemItem: .add)
  }

}
