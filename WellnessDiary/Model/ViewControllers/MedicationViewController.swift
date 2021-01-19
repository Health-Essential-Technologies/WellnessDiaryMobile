//
//  MedicationViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit

class MedicationViewController: SimpleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func initialSetup() {
    super.initialSetup()
    
    let userBtn = SimpleButton(type: .contactAdd)
    navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
  }

}
