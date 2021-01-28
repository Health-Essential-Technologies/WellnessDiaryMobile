//
//  PickerViewDelegateHandler.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class PickerViewDelegateHandler: NSObject {
    
    // MARK: - Properties
    
    var pickerViewInfoProvider: PickerViewInfoProvider?
}

// MARK: - UIPickerViewDelegate

extension PickerViewDelegateHandler: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  pickerViewInfoProvider?.pickerView(pickerView, titleForRow: row, forComponent: component)
    }

}
