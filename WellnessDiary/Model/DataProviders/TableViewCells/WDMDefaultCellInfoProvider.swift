//
//  WDMDefaultCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/30/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMDefaultCellInfoProvider: WDMCellInfoProvider {

  // MARK: - Properties
  
  var mainLabelText: String?
  var detailLabelText: String?
  
  // MARK: - Initializers
  
  init(mainLabelText: String?, detailLabelText: String? = nil) {
    self.mainLabelText = mainLabelText
    self.detailLabelText = detailLabelText
  }
}
