//
//  WDMDefaultTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMDefaultTableViewCell: WDMSimpleTableViewCell {
  
  // MARK: - Properties
  
  private let detailLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.textAlignment = .right
    lbl.adjustsFontSizeToFitWidth = true
    
    // TODO: need to add some default
    lbl.minimumScaleFactor = 0.5
    return lbl
  }()
  
  // MARK: - Methods
  
  override func initialSetup() {
    
    super.initialSetup()
    contentView.addSubview(detailLabel)
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
    
    detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
    detailLabel.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 8).isActive = true
  }
  
  override func didSetcellInfoProvider() {
    super.didSetcellInfoProvider()
    guard let provider = cellInfoProvider as? WDMDefaultCellInfoProvider else { return }
    detailLabel.text = provider.detailLabelText
  }
  
}
