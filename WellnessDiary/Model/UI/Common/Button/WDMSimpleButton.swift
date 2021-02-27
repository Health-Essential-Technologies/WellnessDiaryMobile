//
//  WDMSimpleButton.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import UIKit

class WDMSimpleButton: UIButton {
  
  // MARK: - Properties
  
  public var layerBackground: UIColor?
  
  override func draw(_ rect: CGRect) {
    initialSetup()
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    // TODO
    layer.cornerRadius = 12
    layer.backgroundColor = layerBackground?.cgColor ?? Colors.mainColor.color.cgColor
  }
  
}
