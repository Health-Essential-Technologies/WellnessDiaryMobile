//
//  WDMSummaryAddTaskViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import UIKit

class WDMSummaryAddTaskViewController: WDMSimpleTableViewController {
  
  // MARK: - Properties
  
  var taskName = ""
  var taskInitialDate = Date()
  var taskRecurrence: (frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>)
  
  // MARK: - Initializers
  
  public init(with taskFrequency: (frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>) = (Set<TaskFrequency>(TaskFrequency.allCases), Set(arrayLiteral: TaskOccurence.beforeBreakfast))) {
    self.taskRecurrence = taskFrequency
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    navigationItem.title = localLoc("ADD_TASK")
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    tableView.isScrollEnabled = false
    
    infoProvider = createInfoProvider()
    
    super.initialSetup()
    
  }
  
  @discardableResult
  override func createInfoProvider() -> WDMTableViewInfoProvider {
    
    // First section
    
    let nameRowInfoProvider = WDMLabelTextFieldCellInfoProvider(mainLabelText: "\("NAME".localize()):", textfieldPlaceHolder: (localLoc("ENTER_TASK_NAME")))
    let firstSectionFirstRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: nameRowInfoProvider, cellType: WDMLabelTextfieldTableViewCell.self)
    
    
    let selectDateRowInfoProvider = WDMDatePickerViewCellInfoProvider(mainLabelText: "\("SELECT_STARTING_DAY".localize()):", pickerStyle: .compact)
    let firstSectionSecondRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: selectDateRowInfoProvider, cellType: WDMDatePickerTableViewCell.self)
    
    let repeatsRowInfoProvider = WDMDefaultCellInfoProvider(mainLabelText: "\("REPEATS".localize()):", detailLabelText: getDetailLabelTextForFrequency() + " | " + getDetailLabelTextForOccurence())
    repeatsRowInfoProvider.cellAccessoryType = .disclosureIndicator
    let firstSectionThirdRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: repeatsRowInfoProvider, cellType: WDMDefaultTableViewCell.self)
    
    let firstSection = TableViewSectionItem(headerTitle: "task information".localize(), footerTitle: nil, sectionRowItems: [firstSectionFirstRow, firstSectionSecondRow, firstSectionThirdRow])
    
    
    // Second section
    
    let dismissClosure: () -> ()? = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
    
    let addBtnRowInfoProvider = WDMSingleButtonCellInfoProvider(mainBtnLabelText: "ADD_TASK".localize(), btnActionTargetClosure:
                                                                ButtonClosureWrapper(dismissClosure))
    let  addBtnFirstRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: addBtnRowInfoProvider, cellType: WDMSingleButtonTableViewCell.self, cellHeight: 44)
    let addBtnSection = TableViewSectionItem(headerTitle: localLoc(" "), footerTitle: nil, sectionRowItems: [addBtnFirstRow])
    
    return WDMSummaryAddTaskInfoProvider(withSectionItems: [firstSection, addBtnSection], presenterViewController: self, frequency: taskRecurrence.frequency, occurence: taskRecurrence.occurence, delegate: self)
  }
  
  private func getDetailLabelTextForFrequency() -> String {
    if taskRecurrence.frequency.count == TaskFrequency.allCases.count {
      return "Every Day".localize()
    } else if taskRecurrence.frequency.isEmpty {
      return "Never".localize()
    } else if taskRecurrence.frequency.count == 1 {
      return "Every".localize() + " " + taskRecurrence.frequency.first!.description()
    } else {
      var str = ""
      taskRecurrence.frequency.sorted().forEach { str += $0.description() + ","}
      str.removeLast()
      return str
    }
  }
  
  private func getDetailLabelTextForOccurence() -> String {
    if taskRecurrence.occurence.count > 1 {
      return "\(taskRecurrence.occurence.count)" + " " + "times a Day".localize()
    }
    return "Once a day".localize()
  }
  
}

extension WDMSummaryAddTaskViewController: TaskRecurrenceSelectionProtocol {
  
  // MARK: - Properties
  
  func add(_ frequency: TaskFrequency) {
    taskRecurrence.frequency.insert(frequency)
    infoProvider = createInfoProvider()
  }
  
  func add(_ occurence: TaskOccurence) {
    taskRecurrence.occurence.insert(occurence)
    infoProvider = createInfoProvider()
  }
  
  func remove(_ frequency: TaskFrequency) {
    taskRecurrence.frequency.remove(frequency)
    infoProvider = createInfoProvider()
  }
  
  func remove(_ occurence: TaskOccurence) {
    taskRecurrence.occurence.remove(occurence)
    infoProvider = createInfoProvider()
  }
}
