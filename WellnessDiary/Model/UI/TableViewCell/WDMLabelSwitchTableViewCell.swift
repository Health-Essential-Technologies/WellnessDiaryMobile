//
//  WDMLabelSwitchTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 2/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMLabelSwitchTableViewCell: WDMSimpleTableViewCell {

  // MARK: - Properties
  
  private var switchControl: UISwitch = {
    let switchControl = WDMSimpleSwitch()
    switchControl.translatesAutoresizingMaskIntoConstraints = false
    switchControl.onTintColor = Colors.mainColor.color
    return switchControl
  }()
  
  // MARK: - Initializers
  
  override func initialSetup() {
    super.initialSetup()
    contentView.addSubview(switchControl)
    NSLayoutConstraint.activate(
    [
      switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
      ])
    
    mainLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    switchControl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
  
  // MARK: - Methods
  
  override func didSetcellInfoProvider() {
    super.didSetcellInfoProvider()
    let infoProvider = cellInfoProvider as! WDMLabelSwitchCellInfoProvider
    switchControl.setOn(infoProvider.isOn, animated: true)
    
  }
  
}
