//
//  MedicationViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit
import CareKit

class WDMMedicationViewController: WDMSimpleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func initialSetup() {
    super.initialSetup()
    navigationItem.rightBarButtonItem = WDMSimpleBarButtomItem(systemItem: .add)
  }

}
