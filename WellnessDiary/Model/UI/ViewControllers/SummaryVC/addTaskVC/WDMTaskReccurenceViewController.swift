//
//  WDMTaskRecurrenceViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/30/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

// This will be used to get the days of the week for the task frequency
private let dateFormatter: DateFormatter = {
  var formatter = DateFormatter()
  formatter.locale = .autoupdatingCurrent
  return formatter
}()

protocol TaskRecurrenceSelectionProtocol: AnyObject {
  
  // MARK: - Methods
  
  func add(_ frequency: TaskFrequency)
  func add(_ occurence: TaskOccurence)
  func remove(_ frequency: TaskFrequency)
  func remove(_ occurence: TaskOccurence)
}

public enum TaskFrequency: Int, CaseIterable, RawComparable {
  
  // MARK: - Cases
  
  case firstDay
  case secondDay
  case thirdDay
  case fourthDay
  case fifthDay
  case sixthDay
  case seventhDay
  
  // MARK: - Properties
  public func description(_ short: Bool = false) -> String {
    if !short {
      return dateFormatter.weekdaySymbols[self.rawValue].localize()
    } else {
      return dateFormatter.shortWeekdaySymbols[self.rawValue].localize()
    }
  }
  
  // MARK: - Methods
  
  func getString(from daysOfWeek: TaskFrequency...) -> String {
    if daysOfWeek.count > 1 {
      var newDaysOfWeek = ""
      for day in daysOfWeek {
        newDaysOfWeek += day.description(true) + ","
      }
      newDaysOfWeek.removeLast()
      return newDaysOfWeek.localize()
    } else {
      return daysOfWeek.first!.description()
    }
  }
  
}

public enum TaskOccurence: String, CaseIterable {
  case beforeBreakfast
  case afterBreakfast
  case beforeLunch
  case afterLunch
  case beforeDinner
  case afterDinner
  
  func getStringLocalize() -> String {
    let strCase = self.rawValue
    let prefix = strCase.description.hasPrefix("after") ? "after" : "before"
    let strArr = strCase.description.components(separatedBy: prefix)
    return prefix.localize() + " " + strArr.last!.description.localize()
  }
}

class WDMTaskRecurrenceViewController: WDMSimpleTableViewController {
  
  // MARK: - Properties
  
  private var frequency: Set<TaskFrequency> = Set<TaskFrequency>()
  private var occurence: Set<TaskOccurence> = Set<TaskOccurence>()
  
  weak var delegate: TaskRecurrenceSelectionProtocol?
  
  // MARK: - Initializers
  
  init(with frequency: Set<TaskFrequency> ,with occurence: Set<TaskOccurence>, with delegate: TaskRecurrenceSelectionProtocol?) {
    self.frequency = frequency
    self.occurence = occurence
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Properties
  
  override func initialSetup() {
    
    navigationItem.title = "task frequency".localize()
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    tableView.isScrollEnabled = false
    
    
    infoProvider = createInfoProvider()
    super.initialSetup()
  }
  
  override func createInfoProvider() -> WDMTableViewInfoProvider {
    
    var frequencyRowItems: [TableViewSectionRowItem] = []
    
    for frequency in TaskFrequency.allCases {
      let mainLblTxt = "Every".localize() + " " + frequency.description()
      let provider = WDMTaskReccurenceCellInfoProvider(mainLabelText: mainLblTxt, frequency: frequency, occurence: nil)
      let rowItem = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: provider, cellType: WDMDefaultTableViewCell.self)
      frequencyRowItems.append(rowItem)
    }
    
    let frequencySectionItem = TableViewSectionItem(headerTitle: "Frequency".localize(), footerTitle: nil, sectionRowItems: frequencyRowItems)
    
    var frequencyOccurenceItems: [TableViewSectionRowItem] = []
    
    TaskOccurence.allCases.forEach {
      let mainLblTxt = $0.getStringLocalize()
      let provider = WDMTaskReccurenceCellInfoProvider(mainLabelText: mainLblTxt, frequency: nil, occurence: $0)
      let rowItem = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: provider, cellType: WDMDefaultTableViewCell.self)
      frequencyOccurenceItems.append(rowItem)
    }
    
    let frequencyOccurenceSectonItem = TableViewSectionItem(headerTitle: "Occurence".localize(), footerTitle: nil, sectionRowItems: frequencyOccurenceItems)
    
    return WDMTaskFrequencyInfoProvider(withSectionItems: [frequencySectionItem, frequencyOccurenceSectonItem], presenterViewController: self, frequency: frequency, occurence: occurence, delegate: delegate)
  }
  
}
