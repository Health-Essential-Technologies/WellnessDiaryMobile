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
  private var taskName = ""
  private var taskInitialDate = Date()
  var frequency: Set<TaskFrequency> = Set<TaskFrequency>()
  var occurence: Set<TaskOccurence> = Set<TaskOccurence>()
  
  weak var delegate: TaskRecurrenceSelectionProtocol?
  weak var textField: WDMSimpleTextField?
  
  // MARK: - Initializers
  
  init(withSectionItems sectionItems: [TableViewSectionItem] = [], presenterViewController: WDMSimpleViewController? = nil, frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>, delegate: TaskRecurrenceSelectionProtocol?) {
    super.init(withSectionItems: sectionItems, presenterViewController: presenterViewController)
    self.frequency = frequency
    self.occurence = occurence
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
    textField = castedCell.textfield
    return castedCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let infoProvider = sectionItems[safe: indexPath.section]?.sectionRowItems[safe: indexPath.row]?.cellInfoProvider else { return }
    
    if infoProvider.cellAccessoryType == .disclosureIndicator {
      presenterViewController?.navigationController?.pushViewController(WDMTaskRecurrenceViewController(with: frequency, with: occurence, with: delegate), animated: true)
    }
    
    super.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  @objc private func addBtnTapped(sender: Any) {
    textField?.resignFirstResponder()
    CarePlanStoreManager.sharedCarePlanStoreManager.addTask(with: taskName, with: taskInitialDate, taskFrequency: Array(frequency).sorted(), taskOccurence: Array(occurence))
  }
  
}

// MARK: - Extension TaskRecurrenceSelectionProtocol

extension WDMSummaryAddTaskInfoProvider: TaskRecurrenceSelectionProtocol {
  
  // MARK: - Functions
  
  func add(_ frequency: TaskFrequency) {
    self.frequency.insert(frequency)
  }
  
  func add(_ occurence: TaskOccurence) {
    self.occurence.insert(occurence)
  }
  
  func remove(_ frequency: TaskFrequency) {
    self.frequency.remove(frequency)
  }
  
  func remove(_ occurence: TaskOccurence) {
    self.occurence.remove(occurence)
  }
  
}

// MARK: - Extension UITextFieldDelegate

extension WDMSummaryAddTaskInfoProvider: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text {
      taskName = text
    }
  }
  
}
