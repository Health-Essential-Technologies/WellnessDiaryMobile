//
//  WDMSummaryAddTaskViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import UIKit

class WDMSummaryAddTaskViewController: WDMSimpleTableViewController {
  
  // MARK: - Properties
  
  var task: WDMTask
  
  // MARK: - Initializers
  
  public init(with taskReccurence: (frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>) = (Set<TaskFrequency>(TaskFrequency.allCases), Set(arrayLiteral: TaskOccurence.beforeBreakfast))) {
    self.task = WDMTask(frequency: taskReccurence.frequency, occurence: taskReccurence.occurence)
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
    
    // ---First section---
    
    // First row
    
    let nameRowInfoProvider = WDMLabelTextFieldCellInfoProvider(mainLabelText: "NAME_:".localize(), textfieldText: task.title, textfieldPlaceHolder: (localLoc("ENTER_TASK_NAME")))
    let nameRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: nameRowInfoProvider, cellType: WDMLabelTextfieldTableViewCell.self)
    
    // Second row
    
    let selectDateRowInfoProvider = WDMDatePickerViewCellInfoProvider(mainLabelText: "SELECT_STARTING_DAY_:".localize(), pickerStyle: .compact)
    let selectDateRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: selectDateRowInfoProvider, cellType: WDMDatePickerTableViewCell.self)
    
    // Third row
    let repeatsRowInfoProvider = WDMDefaultCellInfoProvider(mainLabelText: "REPEATS_:".localize(), detailLabelText: getDetailLabelTextForFrequency() + " | " + getDetailLabelTextForOccurence())
    repeatsRowInfoProvider.cellAccessoryType = .disclosureIndicator
    let repeatsRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: repeatsRowInfoProvider, cellType: WDMDefaultTableViewCell.self)
    
    // Fourth row
    let adherenceInfoProvider = WDMLabelSwitchCellInfoProvider(mainLabelText: "IMPACTS_ADHERENCE_:".localize(), isOn: task.impactsAdherence)
    let adherenceRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: adherenceInfoProvider, cellType: WDMLabelSwitchTableViewCell.self)
    
    // Fifth row
    let notificationInfoProvider = WDMLabelSwitchCellInfoProvider(mainLabelText: "ADD_NOTIFICATION_:".localize(), isOn: task.hasNotification)
    
    // Sixth row
    
    let instructionsInfoProvider = WDMLabelTextFieldCellInfoProvider(mainLabelText: "INSTRUCTIONS_:".localize(), textfieldText: "", textfieldPlaceHolder: "TAKE_WITH_A_MEAL".localize())
    let instructionsRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: instructionsInfoProvider, cellType: WDMLabelTextfieldTableViewCell.self)
    
    var footer = "IMPACT_ADHERENCE_-_ALLOWS_USERS_TO_DECIDE_WHETHER_OR_NOT_A_TASK_SHOULD_AFFECT_THEIR_DAILY_GOALS".localize()
    footer.append("\n\n")
    footer.append("INSTRUCTIONS_-_DESCRIBES_IMPORTANT_INFORMATION_ON_HOW_A_TASK_SHOULD_BE_COMPLETED_.".localize())
    
    let firstSection = TableViewSectionItem(headerTitle: "TASK_INFORMATION".localize(), footerTitle: footer, sectionRowItems: [nameRow, selectDateRow, repeatsRow, adherenceRow, instructionsRow])
    
    
    // ---Second section---
    
    // First row
    let dismissClosure: () -> ()? = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
    
    let addBtnRowInfoProvider = WDMSingleButtonCellInfoProvider(mainBtnLabelText: "ADD_TASK".localize(), btnActionTargetClosure:
                                                                ButtonClosureWrapper(dismissClosure))
    let  addBtnFirstRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: addBtnRowInfoProvider, cellType: WDMSingleButtonTableViewCell.self, cellHeight: 44)
    let addBtnSection = TableViewSectionItem(headerTitle: localLoc(" "), footerTitle: nil, sectionRowItems: [addBtnFirstRow])
    
    return WDMSummaryAddTaskInfoProvider(withSectionItems: [firstSection, addBtnSection], presenterViewController: self, task: task, delegate: self)
  }
  
  private func getDetailLabelTextForFrequency() -> String {
    // NEEDS TO FIX FOR LOCALE
    if task.frequency.count == TaskFrequency.allCases.count {
      return "EVERY_DAY".localize()
    } else if task.frequency.isEmpty {
      return "NEVER".localize()
    } else if task.frequency.count == 1 {
      return "Every".localize() + " " + task.frequency.first!.description()
    } else {
      var str = ""
      task.frequency.sorted().forEach { str += $0.description() + ","}
      str.removeLast()
      return str
    }
  }
  
  private func getDetailLabelTextForOccurence() -> String {
    return "TIMES_A_DAY".localize(comment: "Times of day a task is supposed to happen.", count: task.occurence.count)
  }
  
}

extension WDMSummaryAddTaskViewController: TaskRecurrenceSelectionProtocol {
  
  // MARK: - Methods
  
  func add(_ frequency: TaskFrequency) {
    task.frequency.insert(frequency)
    infoProvider = createInfoProvider()
  }
  
  func add(_ occurence: TaskOccurence) {
    task.occurence.insert(occurence)
    infoProvider = createInfoProvider()
  }
  
  func remove(_ frequency: TaskFrequency) {
    task.frequency.remove(frequency)
    infoProvider = createInfoProvider()
  }
  
  func remove(_ occurence: TaskOccurence) {
    task.occurence.remove(occurence)
    infoProvider = createInfoProvider()
  }
  
  func updateName(_ taskTitle: String) {
    task.title = taskTitle
  }
  
  func updateInstructions(_ taskInstructions: String) {
    task.instructions = taskInstructions
  }
  
  func updateNotification(_ taskNotification: String?) {
    task.notificationIdentifier = taskNotification
  }
  
}
