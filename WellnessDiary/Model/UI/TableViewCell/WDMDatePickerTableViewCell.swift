//
//  WDMDatePickerTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMDatePickerTableViewCell: WDMSimpleTableViewCell {
  
  // MARK: - Properties
   
  let datePicker: WDMSimpleDatePicker = {
    let picker = WDMSimpleDatePicker()
    picker.datePickerMode = .date
    picker.maximumDate = Date(timeIntervalSinceNow: 0)
    picker.backgroundColor = .none
    picker.translatesAutoresizingMaskIntoConstraints  = false
    return picker
  }()
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    
    contentView.addSubview(datePicker)
    datePicker.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 8).isActive = true
    datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    datePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    
    mainLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    datePicker.setContentHuggingPriority(.defaultLow, for: .horizontal)
  }
  
  
  @objc func pickerValueChanged(sender: UIDatePicker) {
    datePicker.resetBackground()
  }
  
  override func didSetcellInfoProvider() {
    super.didSetcellInfoProvider()
    guard let datePickerViewInfoProvider = cellInfoProvider as? WDMDatePickerViewCellInfoProvider else { return }
    datePicker.preferredDatePickerStyle = datePickerViewInfoProvider.pickerStyle
    
    datePicker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
  }
  
  
}

