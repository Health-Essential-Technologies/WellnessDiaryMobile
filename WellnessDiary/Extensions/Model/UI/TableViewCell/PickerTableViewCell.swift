//
//  PickerTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class PickerTableViewCell: SimpleTableViewCell {
    
    // MARK: - Properties
    
    var cellDataSource: PickerViewDataSourceHandler?
    
    var mainLabelText = "" {
        didSet  {
            mainLabel.text = mainLabelText
        }
    }
    
    let mainLabel: SimpleLabel = {
       let lbl = SimpleLabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
       return lbl
    }()
    
    let pickerView: SimplePickerView = {
       let picker = SimplePickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.clipsToBounds = true
        return picker
    }()
    
    // MARK: - Methods
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(mainLabel)
        mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        mainLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        // Subclass of this cell will have to set the constraint for pickerview.
        // contentView.addSubview(pickerView)
//        pickerView.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 8).isActive = true
//        pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        pickerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func didSetcellInfoProvider() {
        guard let cellInfoProvider = cellInfoProvider as? PickerViewInfoProvider else { return }
        mainLabelText = cellInfoProvider.mainLabelText
        pickerView.selectRow(cellInfoProvider.defaultValue.row, inComponent: cellInfoProvider.defaultValue.component, animated: false)
    }

}
