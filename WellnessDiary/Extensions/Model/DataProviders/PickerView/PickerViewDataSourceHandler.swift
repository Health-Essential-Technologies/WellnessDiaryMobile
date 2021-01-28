//
//  PickerViewDataSourceHandler.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class PickerViewDataSourceHandler: NSObject {
    
    // MARK: - Properties
    
    var pickerViewInfoProvider: PickerViewInfoProvider?
    
}

// MARK: - UIPickerViewDataSource

extension PickerViewDataSourceHandler: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewInfoProvider?.numberOfComponents(in: pickerView) ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewInfoProvider?.pickerView(pickerView, numberOfRowsInComponent: component) ?? 0
    }
}
