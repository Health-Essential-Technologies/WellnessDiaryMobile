//
//  WDMSimpleButton.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit

class WDMSimpleButton: UIButton {
  
  // MARK: - Properties
  
  override func draw(_ rect: CGRect) {
    initialSetup()
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    // TODO
    layer.cornerRadius = 12
    layer.backgroundColor = Colors.mainColor.color.cgColor
  }
  
}
