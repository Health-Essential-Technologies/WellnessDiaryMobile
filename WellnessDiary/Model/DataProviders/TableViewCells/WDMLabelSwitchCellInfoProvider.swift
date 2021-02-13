//
//  WDMLabelSwitchCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 2/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMLabelSwitchCellInfoProvider: WDMCellInfoProvider {
  
  // MARK: - Properties
  
  var isOn: Bool

  // MARK: - Initializers
  
  public init(mainLabelText: String? = "", isOn: Bool = true) {
    self.isOn = isOn
    super.init(mainLabelText: mainLabelText)
  }

}
