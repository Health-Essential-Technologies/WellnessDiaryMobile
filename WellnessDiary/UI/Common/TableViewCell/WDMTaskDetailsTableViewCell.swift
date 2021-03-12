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
  
  private var instructionLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  // MARK: Methods
  
  override func initialSetup() {
    contentView.addSubview(mainLabel)
    
    mainLabel.font = UIFont.boldSystemFont(ofSize: 24)
    
    contentView.addSubview(effectiveDateLabel)
    contentView.addSubview(frequencyOccurenceLabel)
    contentView.addSubview(instructionLabel)
    
    
    NSLayoutConstraint.activate([
      mainLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      mainLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
      mainLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8),
      
      effectiveDateLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
      effectiveDateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
      effectiveDateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      
      frequencyOccurenceLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      frequencyOccurenceLabel.topAnchor.constraint(equalTo: effectiveDateLabel.bottomAnchor, constant: 0),
      frequencyOccurenceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8),
      
      instructionLabel.topAnchor.constraint(equalTo: frequencyOccurenceLabel.bottomAnchor, constant: 0),
      instructionLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 8),
      instructionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      instructionLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8)
    ])
    
  }
  
  override func didSetcellInfoProvider() {
    let infoProvider = cellInfoProvider as! WDMTaskDetailsCellInfoProvider
    mainLabel.text = infoProvider.task.title
    effectiveDateLabel.text = infoProvider.task.detailLabelFrequencyText
    frequencyOccurenceLabel.text = infoProvider.task.detailLabelOccurenceText
    instructionLabel.text = infoProvider.task.instructions
    
  }

}
