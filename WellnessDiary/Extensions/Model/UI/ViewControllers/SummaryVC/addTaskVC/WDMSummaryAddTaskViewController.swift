//
//  WDMSummaryAddTaskViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import Foundation

class WDMSummaryAddTaskViewController: WDMSimpleTableViewController {
  
  // MARK: - Properties
  
  var frequency: Set<TaskFrequency> {
    didSet {
      createInfoProvider()
    }
  }
  
  // MARK: - Initializers
  
  public init(frequency: Set<TaskFrequency> = Set<TaskFrequency>(TaskFrequency.allCases)) {
    self.frequency = frequency
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
    
    let repeatsRowInfoProvider = WDMDefaultCellInfoProvider(mainLabelText: "\("REPEATS".localize()):", detailLabelText: getDetailLabelTextForFrequency())
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
    
    return WDMTableViewInfoProvider(withSectionItems: [firstSection, addBtnSection], presenterViewController: self)
  }
  
  private func getDetailLabelTextForFrequency() -> String {
    if frequency.count == TaskFrequency.allCases.count {
      return "Every Day".localize()
    } else if frequency.isEmpty {
      return "Never".localize()
    } else {
      var str = ""
      frequency.forEach { str = $0.rawValue + ","}
      str.removeLast()
      return str
    }
  }
  
}
