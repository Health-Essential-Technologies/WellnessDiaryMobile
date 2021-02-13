//
//  WDMTableViewCellIdentifier.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

enum TableViewCellIdentifier: String {
  case defaultCellIdentifier = "defaultCellIdentifier"
  case pickerViewCellIdentifier = "pickerViewCellIdentifier"
  case datePickerViewCellIdentifier = "datePickerViewCellIdentifier"
  case singleButtonCellIdentifier = "singleButtonCellIdentifier"
  case labelTextfieldCellIdentifier = "labelTextfieldCellIdentifier"
}

class WDMCellInfoProvider: WDMInfoProvider {
  
  // MARK: - Properties
  
  var mainLabelText: String?
  var cellAccessoryType: UITableViewCell.AccessoryType = .none
  
  // MARK: - Initializers
  
  public init(mainLabelText: String? = "") {
    self.mainLabelText = mainLabelText
  }
}
