//
//  WDMSimpleTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMSimpleTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  var cellInfoProvider: WDMCellInfoProvider? {
    didSet {
      didSetcellInfoProvider()
    }
  }
  
  public let mainLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.textAlignment = .left
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  // MARK: - Initializers
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialSetup()
    loadTheme()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    
    contentView.addSubview(mainLabel)
    mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
    mainLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    
    selectionStyle = .none
  }
  
  func didSetcellInfoProvider() {
    mainLabel.text = cellInfoProvider?.mainLabelText
  }
  
}
