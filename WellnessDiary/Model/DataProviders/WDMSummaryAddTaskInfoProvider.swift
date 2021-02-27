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
  
  var task: WDMTask
  weak var delegate: TaskModifierProtocol?
  
  // MARK: - Initializers
  
  init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil, task: WDMTask, delegate: TaskModifierProtocol?) {
    self.task = task
    super.init(withSectionItems: sectionItems, presenterViewController: presenterViewController)
    self.delegate = delegate
  }
  
  // MARK: - Functions
  
  override func getDatePickerTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMDatePickerTableViewCell {
    let cell = super.getDatePickerTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    cell.datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    return cell
  }
  
  override func getSingleButtonTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMSingleButtonTableViewCell {
    let cell = super.getSingleButtonTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    // Will let the tableview selection handle the action
    cell.mainButton.isEnabled = false
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
    
    let dismissClosure: () -> () = {
      self.presenterViewController?.navigationController?.popViewController(animated: true)
    }
    
    if indexPath.section == 1 {
      if tableView.numberOfSections == 3 {
        LocalNotificationsManager.sharedInstance.getPermision { [weak self] success, error in
          guard let self = self else { return }
          if success || !self.task.hasNotification {
            CarePlanStoreManager.sharedCarePlanStoreManager.update(self.task, completion: dismissClosure)
          } else {
            self.showAlertForFailedPermision()
            return
          }
        }

      } else {
        LocalNotificationsManager.sharedInstance.getPermision { [weak self] success, error in
          guard let self = self else { return }
          if success || !self.task.hasNotification {
            CarePlanStoreManager.sharedCarePlanStoreManager.add(self.task, completion: dismissClosure)
          } else {
            self.showAlertForFailedPermision()
            return
          }
        }
        

      }
    } else if indexPath.section == 2 {
      CarePlanStoreManager.sharedCarePlanStoreManager.delete(task, completion: dismissClosure)
    }
    

    super.tableView(tableView, didSelectRowAt: indexPath)
  }
  
}

// MARK: Extension DatePicker

extension WDMSummaryAddTaskInfoProvider {
  @objc func datePickerValueChanged(sender: UIDatePicker) {
    task.startDate = sender.date
    delegate?.updateEffectiveDate(sender.date)
  }
}

// MARK: Extension UITextFieldDelegate

extension WDMSummaryAddTaskInfoProvider: UITextFieldDelegate {
  
  func textFieldDidChangeSelection(_ textField: UITextField) {
    if let text = textField.text {
      switch textField.tag {
      case CellInfoProviderTag.taskNameTextFieldTag.rawValue :
        task.title = text
        delegate?.updateName(text)
        
      case CellInfoProviderTag.taskInstructionsTextFieldTag.rawValue :
        task.instructions = text
        delegate?.updateInstructions(text)
        
      default:
        break
      }
    }
  }
  
}

extension WDMSummaryAddTaskInfoProvider {
  
  // MARK: Methods
  
  @objc func switchControlValueChanged(_ sender: Any) {
    if let control = sender as? WDMSimpleSwitch {
      switch control.tag {
      case CellInfoProviderTag.taskAdherenceSwitchTag.rawValue:
        task.impactsAdherence = control.isOn
        delegate?.updateAdherence(control.isOn)
        
      case CellInfoProviderTag.taskNotificationSwitchTag.rawValue:
        task.hasNotification = control.isOn
        delegate?.updateNotification(control.isOn)
        
      default:
        break
      }
    }
  }
}

extension WDMSummaryAddTaskInfoProvider {
  
  // MARK: Methods
  
  private func showAlertForFailedPermision() {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "PERMISION_RESTRICTED".localize(), message: "UNABLE_TO_SAVE_YOUR_TASK_DUE_TO_FAIL_TO_OBTAIN_PERMISION_TO_PUSH_NOTIFICATION._GO_TO_SETTINGS->WELLNESS_DIARY->NOTIFICATIONS_AND_TURN_ON_ALLOW_NOTIFICATIONS_OR_TURN_OFF_NOTIFICATIONS_FOR_THIS_TASK.".localize(), preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "OK".localize(), style: .cancel)
      alert.addAction(cancelAction)
      
      self.presenterViewController?.present(alert, animated: true)
    }
  }
}
