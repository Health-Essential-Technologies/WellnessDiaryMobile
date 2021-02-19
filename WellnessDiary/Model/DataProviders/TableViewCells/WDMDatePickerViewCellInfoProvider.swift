//
//  WDMDatePickerViewCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMDatePickerViewCellInfoProvider: WDMCellInfoProvider {
    
    // MARK: Properties

  var pickerStyle: UIDatePickerStyle
  var dateSelected: Date
    
    // MARK: - Initializers
    
  init(mainLabelText: String = "", dateSelected: Date, pickerStyle: UIDatePickerStyle = .automatic) {
        self.pickerStyle = pickerStyle
    self.dateSelected = dateSelected
      super.init(mainLabelText: mainLabelText)
    }
  
}

extension WDMDatePickerViewCellInfoProvider {
  
}
