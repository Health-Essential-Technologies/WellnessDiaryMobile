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
    
    // MARK: - Initializers
    
    init(mainLabelText: String = "", pickerStyle: UIDatePickerStyle = .automatic) {
        self.pickerStyle = pickerStyle
      super.init(mainLabelText: mainLabelText)
    }
  
}

extension WDMDatePickerViewCellInfoProvider {
  
}
