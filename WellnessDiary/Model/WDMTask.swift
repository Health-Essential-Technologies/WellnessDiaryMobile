//
//  WDMTask.swift
//  WellnessDiary
//
//  Created by luis flores on 2/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit


internal protocol WDMAnyMutableTask: OCKAnyTask {
    var title: String? { get set }
    var instructions: String? { get set }
    var impactsAdherence: Bool { get set }
    var schedule: OCKSchedule { get set }
}

public struct WDMTask: WDMAnyMutableTask & Equatable & Identifiable & Codable {
  
  /// The version ID in the local database of the care plan to which this task belongs.
  public var carePlanID: OCKLocalVersionID?
  
  // MARK: - Properties
  
  public var id: String
  public var title: String?
  public var instructions: String?
  public var impactsAdherence: Bool = true
  public var schedule: OCKSchedule
  public var groupIdentifier: String?
  public var remoteID: String?
  public var notes: [OCKNote]?
  
  public var frequency: Set<TaskFrequency>
  public var occurence: Set<TaskOccurence>
  public var notificationIdentifier: String?
  
  public var hasNotification: Bool {
    return notificationIdentifier != nil
  }
  
  // MARK: - OCKAnyVersionableTask
  public var localDatabaseID: OCKLocalVersionID?
  public var previousVersionID: OCKLocalVersionID?
  public var nextVersionID: OCKLocalVersionID?
  public var effectiveDate: Date
  
  // MARK: - Initializers
  
  init(with id: String = UUID().uuidString, frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>, effectiveDate: Date = Date()) {

    self.schedule = OCKSchedule(composing: [OCKScheduleElement(start: effectiveDate, end: nil, interval: DateComponents(day: 1), duration: .allDay)])
    self.id = id
    self.frequency = frequency
    self.occurence = occurence
    self.effectiveDate = schedule.startDate()
  }
  
  // MARK: - Methods
  
  public func belongs(to plan: OCKAnyCarePlan) -> Bool {
      guard let plan = plan as? OCKCarePlan, let planID = plan.localDatabaseID else { return false }
      return carePlanID == planID
  }
  
  
  private func get(_ occurence: TaskOccurence) -> Int {
    switch occurence {
    case .beforeBreakfast:
      return 7
    case .afterBreakfast:
      return 9
    case .beforeLunch:
      return 11
    case .afterLunch:
      return 13
    case .beforeDinner:
      return 18
    case .afterDinner:
      return 20
    }
  }

  
  public mutating func createScheduleBeforeSaving() {
    var schedules: [OCKSchedule] = []
    if !frequency.isEmpty {
      for frequency in frequency {
        for occurence in occurence {
          schedules.append(OCKSchedule.weeklyAtTime(weekday: frequency.rawValue + 1, hours: get(occurence), minutes: 0, start: effectiveDate, end: nil, targetValues: [], text: title ?? "" + " " + occurence.rawValue.uppercased().localize()))
        }
      }
    } else {
      let scheduleElement = OCKScheduleElement(start: effectiveDate, end: effectiveDate, interval: DateComponents(day:0), text: title, targetValues: [], duration: .allDay)
      schedules.append(OCKSchedule(composing: [scheduleElement]))
    }
    schedule = OCKSchedule(composing: schedules)
    effectiveDate = schedule.startDate()
  }
}
