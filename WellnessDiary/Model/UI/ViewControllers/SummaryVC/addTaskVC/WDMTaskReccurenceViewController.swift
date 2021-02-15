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

protocol TaskModifierProtocol: AnyObject {
  
  // MARK: - Methods
  
  func add(_ frequency: TaskFrequency)
  func add(_ occurence: TaskOccurence)
  func remove(_ frequency: TaskFrequency)
  func remove(_ occurence: TaskOccurence)
  func updateName(_ taskTitle: String)
  func updateInstructions(_ taskInstructions: String)
  func updateAdherence(_ taskAdherence: Bool)
  func updateNotification(_ hasNotification: Bool)
}

public enum TaskFrequency: Int, CaseIterable, Codable, RawComparable {
  
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
      return dateFormatter.weekdaySymbols[self.rawValue].uppercased().localize()
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

public enum TaskOccurence: String, Codable, CaseIterable {
  case beforeBreakfast = "BEFORE_BREAKFAST"
  case afterBreakfast = "AFTER_BREAKFAST"
  case beforeLunch = "BEFORE_LUNCH"
  case afterLunch = "AFTER_LUNCH"
  case beforeDinner = "BEFORE_DINNER"
  case afterDinner = "AFTER_DINNER"

}

class WDMTaskRecurrenceViewController: WDMSimpleTableViewController {
  
  // MARK: - Properties
  
  private var frequency: Set<TaskFrequency> = Set<TaskFrequency>()
  private var occurence: Set<TaskOccurence> = Set<TaskOccurence>()
  
  weak var delegate: TaskModifierProtocol?
  
  // MARK: - Initializers
  
  init(with frequency: Set<TaskFrequency> ,with occurence: Set<TaskOccurence>, with delegate: TaskModifierProtocol?) {
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
    
    navigationItem.title = "TASK_FREQUENCY".localize()
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    tableView.isScrollEnabled = false
    
    
    infoProvider = createInfoProvider()
    super.initialSetup()
  }
  
  override func createInfoProvider() -> WDMTableViewInfoProvider {
    
    var frequencyRowItems: [TableViewSectionRowItem] = []
    
    for frequency in TaskFrequency.allCases {
      let mainLblTxt = "EVERY".localize() + " " + frequency.description()
      let provider = WDMTaskReccurenceCellInfoProvider(mainLabelText: mainLblTxt, frequency: frequency, occurence: nil)
      let rowItem = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: provider, cellType: WDMDefaultTableViewCell.self)
      frequencyRowItems.append(rowItem)
    }
    
    let frequencySectionItem = TableViewSectionItem(headerTitle: "FREQUENCY".localize(), footerTitle: nil, sectionRowItems: frequencyRowItems)
    
    var frequencyOccurenceItems: [TableViewSectionRowItem] = []
    
    TaskOccurence.allCases.forEach {
      let mainLblTxt = $0.rawValue.uppercased().localize()
      let provider = WDMTaskReccurenceCellInfoProvider(mainLabelText: mainLblTxt, frequency: nil, occurence: $0)
      let rowItem = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: provider, cellType: WDMDefaultTableViewCell.self)
      frequencyOccurenceItems.append(rowItem)
    }
    
    let frequencyOccurenceSectonItem = TableViewSectionItem(headerTitle: "OCCURENCE".localize(), footerTitle: nil, sectionRowItems: frequencyOccurenceItems)
    
    return WDMTaskFrequencyInfoProvider(withSectionItems: [frequencySectionItem, frequencyOccurenceSectonItem], presenterViewController: self, frequency: frequency, occurence: occurence, delegate: delegate)
  }
  
}
