//
//  DatePickerViewCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class DatePickerViewCellInfoProvider: CellInfoProvider {
    
    // MARK: Properties
    
    var mainLabelText: String
    var pickerStyle: UIDatePickerStyle
    
    // MARK: - Initializers
    
    init(mainLabelText: String = "", pickerStyle: UIDatePickerStyle = .automatic) {
        self.mainLabelText = mainLabelText
        self.pickerStyle = pickerStyle
    }
}
