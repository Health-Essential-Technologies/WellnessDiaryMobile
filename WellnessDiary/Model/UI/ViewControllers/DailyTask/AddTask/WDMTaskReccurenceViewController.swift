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
  func updateEffectiveDate(_ effectiveDate: Date)
  func updateInstructions(_ taskInstructions: String)
  func updateAdherence(_ taskAdherence: Bool)
  func updateNotification(_ hasNotification: Bool)
}

public enum TaskFrequency: Int, CaseIterable, Codable {

  // MARK: Cases
  
  case firstDay = 1
  case secondDay
  case thirdDay
  case fourthDay
  case fifthDay
  case sixthDay
  case seventhDay

  // MARK: - Methods
  
  public func description(_ short: Bool = false) -> String {
    if !short {
      return dateFormatter.weekdaySymbols[self.rawValue - 1].uppercased().localize()
    } else {
      return dateFormatter.shortWeekdaySymbols[self.rawValue - 1].localize()
    }
  }
  
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
  
  static public func getFrequency(from date: Date) -> TaskFrequency {
    let dateComponent = Calendar.current.component(.weekday, from: Calendar.current.startOfDay(for: date))
    
    switch dateComponent {
    case 1:
      return TaskFrequency.firstDay
    case 2:
      return TaskFrequency.secondDay
    case 3:
      return TaskFrequency.thirdDay
    case 4:
      return TaskFrequency.fourthDay
    case 5:
      return TaskFrequency.fifthDay
    case 6:
      return TaskFrequency.sixthDay
    default:
      return TaskFrequency.seventhDay
    }
  }
}

extension TaskFrequency: Comparable {
  
  // MARK: Methods
  
  public static func < (lhs: TaskFrequency, rhs: TaskFrequency) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  
}

public enum TaskOccurence: Int, Codable, CaseIterable {
  
  // MARK: Cases
  case beforeBreakfast = 7
  case afterBreakfast = 9
  case beforeLunch = 12
  case afterLunch = 14
  case beforeDinner = 19
  case afterDinner = 20
  
  // MARK: Methods
  
  static public func getTaskAsStringFrom(_ occurence: TaskOccurence) -> String {
    switch occurence {
    case .beforeBreakfast:
      return "BEFORE_BREAKFAST"
    case .afterBreakfast:
      return "AFTER_BREAKFAST"
    case .beforeLunch:
      return "BEFORE_LUNCH"
    case .afterLunch:
      return "AFTER_LUNCH"
    case .beforeDinner:
      return "BEFORE_DINNER"
    case .afterDinner:
      return "AFTER_DINNER"
    }
  }
  
  static public func getOccurence(from date: Date) -> TaskOccurence {
    
    let dateComponent = Calendar.current.component(.hour, from: date)
  
    switch dateComponent {
    case TaskOccurence.beforeBreakfast.rawValue:
      return .beforeBreakfast
    case TaskOccurence.afterBreakfast.rawValue:
      return .afterBreakfast
    case TaskOccurence.beforeLunch.rawValue:
      return .beforeLunch
    case TaskOccurence.afterLunch.rawValue:
      return .afterLunch
    case TaskOccurence.beforeDinner.rawValue:
    return beforeDinner
    case TaskOccurence.afterDinner.rawValue:
      return .afterDinner
    default:
      fatalError("This should never be called. Occurence is not part of the enum.")
    }
  }
}

extension TaskOccurence: Comparable {
  
  // MARK: Methods
  
  public static func < (lhs: TaskOccurence, rhs: TaskOccurence) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  
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
      let mainLblTxt = TaskOccurence.getTaskAsStringFrom($0).localize()
      let provider = WDMTaskReccurenceCellInfoProvider(mainLabelText: mainLblTxt, frequency: nil, occurence: $0)
      let rowItem = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: provider, cellType: WDMDefaultTableViewCell.self)
      frequencyOccurenceItems.append(rowItem)
    }
    
    let frequencyOccurenceSectonItem = TableViewSectionItem(headerTitle: "OCCURENCE".localize(), footerTitle: nil, sectionRowItems: frequencyOccurenceItems)
    
    return WDMTaskFrequencyInfoProvider(withSectionItems: [frequencySectionItem, frequencyOccurenceSectonItem], presenterViewController: self, frequency: frequency, occurence: occurence, delegate: delegate)
  }
  
}
