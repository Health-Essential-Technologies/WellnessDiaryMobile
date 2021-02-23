//
//  WDMSummaryAddTaskViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import UIKit

class WDMSummaryAddTaskViewController: WDMSimpleTableViewController {
  
  // MARK: - Properties
  
  private var task: WDMTask
  private var editMode: Bool
  
  // MARK: - Initializers
  
  public init(with task: WDMTask, editMode: Bool = false) {
    self.task = task
    self.editMode = editMode
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  deinit {
    print("Remove add task view")
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    if !editMode {
      navigationItem.title = localLoc("ADD_TASK")
    } else {
      navigationItem.title = "EDIT_TASK".localize()
    }
    
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
    nameRowInfoProvider.itemTag = CellInfoProviderTag.taskNameTextFieldTag
    
    let nameRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: nameRowInfoProvider, cellType: WDMLabelTextfieldTableViewCell.self)
    
    // Second row
    
    let selectDateRowInfoProvider = WDMDatePickerViewCellInfoProvider(mainLabelText: "SELECT_STARTING_DAY_:".localize(),dateSelected: task.startDate, pickerStyle: .compact)
    let selectDateRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: selectDateRowInfoProvider, cellType: WDMDatePickerTableViewCell.self)
    
    // Third row
    let repeatsRowInfoProvider = WDMDefaultCellInfoProvider(mainLabelText: "REPEATS_:".localize(), detailLabelText: task.detailLabelFrequencyText + " | " + task.detailLabelOccurenceText)
    repeatsRowInfoProvider.cellAccessoryType = .disclosureIndicator
    let repeatsRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: repeatsRowInfoProvider, cellType: WDMDefaultTableViewCell.self)
    
    // Fourth row
    let adherenceInfoProvider = WDMLabelSwitchCellInfoProvider(mainLabelText: "IMPACTS_ADHERENCE_:".localize(), isOn: task.impactsAdherence)
    adherenceInfoProvider.itemTag = CellInfoProviderTag.taskAdherenceSwitchTag
    
    let adherenceRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: adherenceInfoProvider, cellType: WDMLabelSwitchTableViewCell.self)
    
    // Fifth row
    let notificationInfoProvider = WDMLabelSwitchCellInfoProvider(mainLabelText: "ADD_NOTIFICATION_:".localize(), isOn: task.hasNotification)
    notificationInfoProvider.itemTag = CellInfoProviderTag.taskNotificationSwitchTag
    
    let notificationRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: notificationInfoProvider, cellType: WDMLabelSwitchTableViewCell.self)
    
    // Sixth row
    
    let instructionsInfoProvider = WDMLabelTextFieldCellInfoProvider(mainLabelText: "INSTRUCTIONS_:".localize(), textfieldText: task.instructions, textfieldPlaceHolder: "TAKE_WITH_A_MEAL".localize())
    instructionsInfoProvider.itemTag = CellInfoProviderTag.taskInstructionsTextFieldTag
    
    let instructionsRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: instructionsInfoProvider, cellType: WDMLabelTextfieldTableViewCell.self)
    
    var footer = "IMPACT_ADHERENCE_-_ALLOWS_USERS_TO_DECIDE_WHETHER_OR_NOT_A_TASK_SHOULD_AFFECT_THEIR_DAILY_GOALS".localize()
    footer.append("\n\n")
    footer.append("INSTRUCTIONS_-_DESCRIBES_IMPORTANT_INFORMATION_ON_HOW_A_TASK_SHOULD_BE_COMPLETED_.".localize())
    
    let firstSection = TableViewSectionItem(headerTitle: "TASK_INFORMATION".localize(), footerTitle: footer, sectionRowItems: [nameRow, selectDateRow, repeatsRow, adherenceRow, notificationRow, instructionsRow])
    
    
    // ---Second section---
    
    // First row
    let dismissClosure: () -> ()? = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
    
    var sections = [firstSection]
    
    if !editMode {
      let addBtnRowInfoProvider = WDMSingleButtonCellInfoProvider(mainBtnLabelText: "ADD_TASK".localize(), btnActionTargetClosure:
                                                                    ButtonClosureWrapper(dismissClosure))
      let  addBtnFirstRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: addBtnRowInfoProvider, cellType: WDMSingleButtonTableViewCell.self, cellHeight: 44)
      let addBtnSection = TableViewSectionItem(headerTitle: localLoc(" "), footerTitle: nil, sectionRowItems: [addBtnFirstRow])
      sections.append(addBtnSection)
    } else {
      let editButtonInfoProvider = WDMSingleButtonCellInfoProvider(mainBtnLabelText: "UPDATE_TASK".localize(), btnActionTargetClosure:
                                                                    ButtonClosureWrapper(dismissClosure))
      let  editBtnFirstRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: editButtonInfoProvider, cellType: WDMSingleButtonTableViewCell.self, cellHeight: 44)
      let editBtnSection = TableViewSectionItem(headerTitle: "", footerTitle: "", sectionRowItems: [editBtnFirstRow])
      sections.append(editBtnSection)
      
      
      let deleteButtonInfoProvider = WDMSingleButtonCellInfoProvider(mainBtnLabelText: "DELETE_TASK".localize(), backgroundColor: Colors.deleteButtonEditTask.color, btnActionTargetClosure: ButtonClosureWrapper(dismissClosure))
      let deleteBtnSecondRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: deleteButtonInfoProvider, cellType: WDMSingleButtonTableViewCell.self, cellHeight: 44)
      let editDeleteSection = TableViewSectionItem(headerTitle: localLoc(""), footerTitle: nil, sectionRowItems: [deleteBtnSecondRow])
      sections.append(editDeleteSection)
    }
    
    return WDMSummaryAddTaskInfoProvider(withSectionItems: sections, presenterViewController: self, task: task, delegate: self)
  }
  
}

extension WDMSummaryAddTaskViewController: TaskModifierProtocol {
  
  // MARK: - Methods
  
  func add(_ frequency: TaskFrequency) {
    task.taskRecurrence.frequency.insert(frequency)
    infoProvider = createInfoProvider()
  }
  
  func add(_ occurence: TaskOccurence) {
    task.taskRecurrence.occurence.insert(occurence)
    infoProvider = createInfoProvider()
  }
  
  func remove(_ frequency: TaskFrequency) {
    task.taskRecurrence.frequency.remove(frequency)
    infoProvider = createInfoProvider()
  }
  
  func remove(_ occurence: TaskOccurence) {
    task.taskRecurrence.occurence.remove(occurence)
    infoProvider = createInfoProvider()
  }
  
  func updateName(_ taskTitle: String) {
    task.title = taskTitle
  }
  
  func updateInstructions(_ taskInstructions: String) {
    task.instructions = taskInstructions
  }
  
  func updateAdherence(_ taskAdherence: Bool) {
    task.impactsAdherence = taskAdherence
  }
  
  func updateNotification(_ hasNotification: Bool) {
    task.hasNotification = hasNotification
  }
  
  func updateEffectiveDate(_ effectiveDate: Date) {
    task.startDate = effectiveDate
  }
}
