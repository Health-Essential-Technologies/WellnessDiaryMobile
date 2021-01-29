//
//  WDMPickerViewInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMPickerViewInfoProvider: WDMCellInfoProvider {
    
    // MARK: - Properties
    
    let mainLabelText: String
    var pickerComponents: [PickerViewComponentItem] = []
    var defaultValue = (row: 0, component: 0)
    
    // MARK: - Initializers
    
    init(mainLabelText: String = "", pickerComponents: [PickerViewComponentItem]) {
        self.mainLabelText = mainLabelText
        self.pickerComponents = pickerComponents
    }
    
    // MARK: - Methods
    
    public static func createOunceData() -> [PickerViewRowItem] {
        var rowItems: [PickerViewRowItem] = []
        
        for i in -50...50 {
            if i == 0 {
                continue
            }
            rowItems.append(PickerViewRowItem(title: "\(i)"))
        }
        return rowItems
    }
    
    func defaultPickerToValue(InRow row: Int, ForComponent component: Int) -> (row: Int, component: Int) {
        if pickerComponents[safe: component]?.rowItems[safe: row] != nil {
            return (row,component)
        }
        return (0,0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerComponents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerComponents[safe: component]?.rowItems.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerComponents[safe: component]?.rowItems[safe: row]?.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String? {
        return pickerComponents[safe: component]?.rowItems[safe: row]?.title
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerComponents[safe: component]?.rowHeight ?? -1.0
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerComponents[safe: component]?.rowWidth ?? -1.0
    }
    
}
