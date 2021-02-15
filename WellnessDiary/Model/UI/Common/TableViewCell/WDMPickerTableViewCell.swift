//
//  WDMPickerTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMPickerTableViewCell: WDMSimpleTableViewCell {
  
  // MARK: - Properties
  
  var cellDataSource: WDMPickerViewDataSourceHandler?
  
  let pickerView: WDMSimplePickerView = {
    let picker = WDMSimplePickerView()
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.clipsToBounds = true
    return picker
  }()
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    
    // Subclass of this cell will have to set the constraint for pickerview.
    // contentView.addSubview(pickerView)
    //        pickerView.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 8).isActive = true
    //        pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    //        pickerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    //        pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
  
  override func didSetcellInfoProvider() {
    super.didSetcellInfoProvider()
    guard let cellInfoProvider = cellInfoProvider as? WDMPickerViewInfoProvider else { return }
    pickerView.selectRow(cellInfoProvider.defaultValue.row, inComponent: cellInfoProvider.defaultValue.component, animated: false)
  }
  
}
