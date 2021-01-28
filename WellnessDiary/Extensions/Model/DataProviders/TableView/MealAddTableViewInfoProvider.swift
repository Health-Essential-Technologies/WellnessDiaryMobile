//
//  MealAddTableViewInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class MealAddTableViewInfoProvider: TableViewInfoProvider {

    // MARK: - Properties
    
    var liquidValue = 0.0
    var dateCreated = Date()
    
    private var pickerCellInfoProvider: PickerViewInfoProvider?
    
    // MARK: - Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = super.tableView(tableView, cellForRowAt: indexPath) as? SimpleTableViewCell else { return UITableViewCell() }
        
        switch cell.self {
        
        case is DatePickerTableViewCell :
            let castedCell = cell as! DatePickerTableViewCell
            castedCell.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
            cell = castedCell
            break
            
        case is PickerTableViewCell:
            let castedCell = cell as! PickerTableViewCell
            if let castedInfoProvider = castedCell.cellInfoProvider as? PickerViewInfoProvider {
                pickerCellInfoProvider = castedInfoProvider
            }
            castedCell.pickerView.delegate = self
            
            if castedCell is MealAddPickerViewTableViewCell {
                cell = getMealAddPickerViewTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cell as! MealAddPickerViewTableViewCell)
            }
            
            cell = castedCell
            break
        
        case is SingleButtonTableViewCell:
            let castedCell = cell as! SingleButtonTableViewCell
            castedCell.mainButton.addTarget(tableView, action: #selector(tableView.reloadData), for: .touchUpInside)
            castedCell.mainButton.addTarget(self, action: #selector(saveLiquid), for: .touchUpInside)
            cell = castedCell
            break
            
        default:
            break
            
        }
        
        return cell
    }
    
    private func getMealAddPickerViewTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cell: MealAddPickerViewTableViewCell) -> SimpleTableViewCell {
        
        // TODO: Needs to be fixed
        cell.unitLabel.text = "oz"
        return cell
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        dateCreated = sender.date
    }
    
    @objc func saveLiquid() {
        if liquidValue == 0.0 {
            liquidValue = 1
        }
        
//        CoreDataManager.sharedManager.saveFLuidEntry(WithLiquidValue: liquidValue, ForDate: dateCreated)
    }
    
}

extension MealAddTableViewInfoProvider: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCellInfoProvider?.pickerView(pickerView, titleForRow: row, forComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let pickerValue = pickerCellInfoProvider?.pickerView(pickerView, didSelectRow: row, inComponent: component) else { return }
        
        liquidValue = Double(pickerValue) ?? 0
        
    }
    
}

