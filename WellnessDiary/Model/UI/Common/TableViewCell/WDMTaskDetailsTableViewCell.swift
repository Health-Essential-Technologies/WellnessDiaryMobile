//
//  WDMTaskDetailsTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMTaskDetailsTableViewCell: WDMSimpleTableViewCell {

  // MARK: Properties
  
  private var effectiveDateLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  private var frequencyOccurenceLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  // MARK: Methods
  
  override func initialSetup() {
    contentView.addSubview(mainLabel)
    contentView.addSubview(effectiveDateLabel)
    contentView.addSubview(frequencyOccurenceLabel)
    
    
    NSLayoutConstraint.activate([
      mainLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      mainLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
      mainLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8),
      
      effectiveDateLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
      effectiveDateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
      effectiveDateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      
      frequencyOccurenceLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      frequencyOccurenceLabel.topAnchor.constraint(equalTo: effectiveDateLabel.bottomAnchor, constant: 8),
      frequencyOccurenceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
      frequencyOccurenceLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8)
    ])
    
  }
  
  override func didSetcellInfoProvider() {
    let infoProvider = cellInfoProvider as! WDMTaskDetailsCellInfoProvider
    mainLabel.text = infoProvider.task.title
    effectiveDateLabel.text = DateFormatter().string(from: infoProvider.task.startDate)
    frequencyOccurenceLabel.text = DateFormatter().string(from: infoProvider.task.startDate)
    
  }

}
