//
//  WDMSummaryAddTaskInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/31/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSummaryAddTaskInfoProvider: WDMTableViewInfoProvider {
  
  private let NAME_TEXTFIELD_TAG = 1
  private let INSTRUCTIONS_TEXTFIELD_TAG = 2
  
  // MARK: - Properties
  
  var task: WDMTask
  weak var delegate: TaskRecurrenceSelectionProtocol?
  weak var textField: WDMSimpleTextField?
  
  // MARK: - Initializers
  
  init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil, task: WDMTask, delegate: TaskRecurrenceSelectionProtocol?) {
    self.task = task
    super.init(withSectionItems: sectionItems, presenterViewController: presenterViewController)
    self.delegate = delegate
  }
  
  // MARK: - Functions
  
  override func getSingleButtonTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSimpleTableViewCell {
    let cell = super.getSingleButtonTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem) as! WDMSingleButtonTableViewCell
    cell.mainButton.addTarget(self, action: #selector(addBtnTapped(sender:)), for: .touchUpInside)
    return cell
  }
  
  override func getLabelTextfieldTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMLabelTextfieldTableViewCell {
    let castedCell = super.getLabelTextfieldTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    castedCell.textfield.delegate = self
    if castedCell.mainLabel.text == "Name:" {
      castedCell.textfield.tag = NAME_TEXTFIELD_TAG
    } else if castedCell.mainLabel.text == "Instructions:" {
      castedCell.textfield.tag = INSTRUCTIONS_TEXTFIELD_TAG
    }
    textField = castedCell.textfield
    return castedCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let infoProvider = sectionItems[safe: indexPath.section]?.sectionRowItems[safe: indexPath.row]?.cellInfoProvider else { return }
    
    if infoProvider.cellAccessoryType == .disclosureIndicator {
      presenterViewController?.navigationController?.pushViewController(WDMTaskRecurrenceViewController(with: task.frequency, with: task.occurence, with: delegate), animated: true)
    }
    
    super.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  @objc private func addBtnTapped(sender: Any) {
    textField?.resignFirstResponder()
    task.createScheduleBeforeSaving()
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
