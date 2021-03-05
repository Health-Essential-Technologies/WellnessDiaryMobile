//
//  WDMTableViewCellIdentifier.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

public enum CellInfoProviderTag: Int {
  case noTag
  case taskNameTextFieldTag
  case taskInstructionsTextFieldTag
  case taskAdherenceSwitchTag
  case taskNotificationSwitchTag
  case sleepTimeSwitchTag
  case sleepQualitySwitchTag
  case temperatureSwitchTag
  case bloodPressureSwitchTag
  case heartBeatSwitchTag
  case weightSwitchTag
  case bloodSugarSwitchTag
  case painlevelSwitchTag
}

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
  var itemTag: CellInfoProviderTag = .noTag
  var cellAccessoryType: UITableViewCell.AccessoryType = .none
  
  // MARK: - Initializers
  
  public init(mainLabelText: String? = "") {
    self.mainLabelText = mainLabelText
  }
}
