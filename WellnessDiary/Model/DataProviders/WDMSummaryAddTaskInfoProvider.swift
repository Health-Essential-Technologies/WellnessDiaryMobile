//
//  WDMSummaryAddTaskInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/31/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSummaryAddTaskInfoProvider: WDMTableViewInfoProvider {
  
  // MARK: - Properties
  
  var task = WDMTask()
  weak var delegate: TaskModifierProtocol?
  
  // MARK: - Initializers
  
  init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil, task: WDMTask, delegate: TaskModifierProtocol?) {
    self.task = task
    super.init(withSectionItems: sectionItems, presenterViewController: presenterViewController)
    self.delegate = delegate
  }
  
  // MARK: - Functions
  
  override func getSingleButtonTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSingleButtonTableViewCell {
    let cell = super.getSingleButtonTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    cell.mainButton.addTarget(self, action: #selector(addBtnTapped(sender:)), for: .touchUpInside)
    return cell
  }
  
  override func getLabelTextfieldTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMLabelTextfieldTableViewCell {
    let castedCell = super.getLabelTextfieldTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    castedCell.textfield.delegate = self
    return castedCell
  }
  
  override func getLabelSwitchTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMLabelSwitchTableViewCell {
    let castedCell = super.getLabelSwitchTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
  
    castedCell.switchControl.addTarget(self, action: #selector(switchControlValueChanged(_:)), for: .valueChanged)
    return castedCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let infoProvider = sectionItems[safe: indexPath.section]?.sectionRowItems[safe: indexPath.row]?.cellInfoProvider else { return }
    
    if infoProvider.cellAccessoryType == .disclosureIndicator {
      presenterViewController?.navigationController?.pushViewController(WDMTaskRecurrenceViewController(with: task.taskRecurrence.frequency, with: task.taskRecurrence.occurence, with: delegate), animated: true)
    }
    
    super.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  @objc private func addBtnTapped(sender: Any) {
    CarePlanStoreManager.sharedCarePlanStoreManager.add(task)
  }
  
}

// MARK: - Extension UITextFieldDelegate

extension WDMSummaryAddTaskInfoProvider: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text {
      switch textField.tag {
      
      case NAME_TEXTFIELD_TAG:
        task.title = text
        delegate?.updateName(text)
        
      case INSTRUCTIONS_TEXTFIELD_TAG:
        task.instructions = text
        delegate?.updateInstructions(text)
        
      default:
        break
      }
    }
  }
}
