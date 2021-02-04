//
//  WDMLabelTextfieldTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/29/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMLabelTextfieldTableViewCell: WDMSimpleTableViewCell {

  // MARK: - Properties
  
  var mainLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  var textfield: WDMSimpleTextField = {
    let txtField = WDMSimpleTextField()
    txtField.translatesAutoresizingMaskIntoConstraints = false
    txtField.textAlignment = .center
    return txtField
  }()
  
  // MARK: - Methods
  
  override func initialSetup() {
    
    super.initialSetup()
    
    [mainLabel, textfield].forEach {contentView.addSubview($0)}
    
    NSLayoutConstraint.activate([
      mainLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: -8),
      mainLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      
      // TODO: Needs to add costant
      textfield.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 8),
      textfield.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      textfield.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
    ])
    
    mainLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    textfield.setContentHuggingPriority(.defaultLow, for: .horizontal)
    
  }
  
  override func didSetcellInfoProvider() {
    guard let infoProvider = cellInfoProvider as? WDMLabelTextFieldCellInfoProvider else { return }
    mainLabel.text = infoProvider.mainLabelText
    textfield.text = infoProvider.textfieldText
    textfield.placeholder = infoProvider.textfieldPlaceHolderText
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
  }
}
