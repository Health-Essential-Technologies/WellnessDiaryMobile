//
//  WDMDailySurveyCompletedChildViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 3/4/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMDailySurveyCompletedChildViewController: WDMSimpleViewController {

  // MARK: Properties
  
  let mainLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    lbl.text = "THANKS_FOR_COMPLETING_YOUR_DAILY_SURVEY_.\n\nHEAD_BACK_TO_THE_SUMMARY'S_PAGE_TO_LOOK_AT_YOUR_WEEKLY_OR_MONTHLY_TRENDS_.".localize()
    
    return lbl
  }()
  
  // MARK: Initializers
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // MARK: Methods
  
  override func initialSetup() {
    super.initialSetup()
    
    view.addSubview(mainLabel)
    
    NSLayoutConstraint.activate([
      mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      mainLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      mainLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ])
  }

}
