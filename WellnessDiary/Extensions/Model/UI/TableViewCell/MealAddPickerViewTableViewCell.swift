//
//  MealAddPickerViewTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class MealAddPickerViewTableViewCell: PickerTableViewCell {
    
    // MARK: - Properties
    
    var unitLabel: UILabel = {
       let lbl = SimpleLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: - Methods
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(unitLabel)
        contentView.addSubview(pickerView)
        
        mainLabel.trailingAnchor.constraint(equalTo: pickerView.leadingAnchor, constant: -8).isActive = true
        
        unitLabel.leadingAnchor.constraint(equalTo: pickerView.trailingAnchor).isActive = true
        unitLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        unitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        unitLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    
        pickerView.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 8).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
