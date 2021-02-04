//
//  WDMDatePickerTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMDatePickerTableViewCell: WDMSimpleTableViewCell {
  
  // MARK: - Properties
  
  var mainLabelText: String = "" {
    didSet {
      mainLabel.text = mainLabelText
    }
  }
  
  private let mainLabel: WDMSimpleLabel = {
    let lbl = WDMSimpleLabel()
    lbl.textAlignment = .left
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
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
    
    contentView.addSubview(mainLabel)
    
    // FIXME: - needs to add layout manager
    mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
    mainLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    
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
    guard let datePickerViewInfoProvider = cellInfoProvider as? WDMDatePickerViewCellInfoProvider else { return }
    mainLabelText = datePickerViewInfoProvider.mainLabelText
    datePicker.preferredDatePickerStyle = datePickerViewInfoProvider.pickerStyle
    
    datePicker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
  }
  
  
}

