//
//  DatePickerTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class DatePickerTableViewCell: SimpleTableViewCell {
    
    // MARK: - Properties
    
    var mainLabelText: String = "" {
        didSet {
            mainLabel.text = mainLabelText
        }
    }
    
    private let mainLabel: SimpleLabel = {
        let lbl = SimpleLabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let datePicker: SimpleDatePicker = {
       let picker = SimpleDatePicker()
        picker.datePickerMode = .dateAndTime
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
        datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

    }
    
    @objc func pickerValueChanged(sender: UIDatePicker) {
        datePicker.resetBackground()
    }
    
    override func didSetcellInfoProvider() {
        guard let datePickerViewInfoProvider = cellInfoProvider as? DatePickerViewCellInfoProvider else { return }
        mainLabelText = datePickerViewInfoProvider.mainLabelText
        datePicker.preferredDatePickerStyle = datePickerViewInfoProvider.pickerStyle
        
        datePicker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
    }
    
    
}

