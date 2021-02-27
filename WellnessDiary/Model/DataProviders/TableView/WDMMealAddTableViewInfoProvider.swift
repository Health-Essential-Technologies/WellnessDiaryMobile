//
//  WDMMealAddTableViewInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMMealAddTableViewInfoProvider: WDMTableViewInfoProvider {

    // MARK: - Properties
    
    private var pickerCellInfoProvider: WDMPickerViewInfoProvider?
    
    // MARK: - Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = super.tableView(tableView, cellForRowAt: indexPath) as? WDMSimpleTableViewCell else { return UITableViewCell() }
        
        switch cell.self {
        
        case is WDMDatePickerTableViewCell :
            let castedCell = cell as! WDMDatePickerTableViewCell
//            castedCell.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
            cell = castedCell
            break
            
        case is WDMPickerTableViewCell:
            let castedCell = cell as! WDMPickerTableViewCell
            if let castedInfoProvider = castedCell.cellInfoProvider as? WDMPickerViewInfoProvider {
                pickerCellInfoProvider = castedInfoProvider
            }
            castedCell.pickerView.delegate = self
            
            if castedCell is WDMMealAddPickerViewTableViewCell {
                cell = getMealAddPickerViewTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cell as! WDMMealAddPickerViewTableViewCell)
            }
            
            cell = castedCell
            break
        
        case is WDMSingleButtonTableViewCell:
            let castedCell = cell as! WDMSingleButtonTableViewCell
            castedCell.mainButton.addTarget(tableView, action: #selector(tableView.reloadData), for: .touchUpInside)
            cell = castedCell
            break
            
        default:
            break
            
        }
        
        return cell
    }
    
    private func getMealAddPickerViewTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cell: WDMMealAddPickerViewTableViewCell) -> WDMSimpleTableViewCell {
        
        // TODO: Needs to be fixed
        cell.unitLabel.text = "oz"
        return cell
    }
  
    
}

extension WDMMealAddTableViewInfoProvider: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCellInfoProvider?.pickerView(pickerView, titleForRow: row, forComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let _ = pickerCellInfoProvider?.pickerView(pickerView, didSelectRow: row, inComponent: component) else { return }
        
    }
    
}

