//
//  WDMSimpleCustomOCKLabelButton.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import Foundation
import CareKitUI

class WDMSimpleCustomOCKLabelButton: OCKLabeledButton {

  // MARK: - Initializers
  
  override init() {
    super.init()
    customSetup()
  }
  
  // MARK: - Methods
  
  override func setStyleForSelectedState(_ isSelected: Bool) {
    // Does nothing since for now this will dismiss the vc once pressed
  }
  
  override func styleDidChange() {
    super.styleDidChange()
    backgroundColor = tintColor
  }
  
  public func customSetup() {
    label.text = localLoc("ADD")
  }
  
}
