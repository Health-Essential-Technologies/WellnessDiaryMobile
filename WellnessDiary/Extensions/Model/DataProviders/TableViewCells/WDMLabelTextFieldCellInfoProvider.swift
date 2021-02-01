//
//  WDMLabelTextFieldCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/29/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMLabelTextFieldCellInfoProvider: WDMCellInfoProvider {

  // MARK: - Properties

  var mainLabelText: String
  var textfieldText: String?
  var textfieldPlaceHolderText: String?
  
  // MARK: - Initializers
  
  init(mainLabelText: String, textfieldText: String? = "", textfieldPlaceHolder: String? = "") {
    self.mainLabelText = mainLabelText
    self.textfieldText = textfieldText
    self.textfieldPlaceHolderText = textfieldPlaceHolder
  }
}
