//
//  WDMTask.swift
//  WellnessDiary
//
//  Created by luis flores on 2/14/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import CareKit

public struct WDMTask {
  
  // MARK: Properties
  
  var title: String? = ""
  var taskRecurrence: (frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>) = (Set(TaskFrequency.allCases), Set(arrayLiteral: TaskOccurence.beforeBreakfast))
  var impactsAdherence: Bool = true
  var hasNotification: Bool = true
  var instructions: String? = ""
  var effectiveDate: Date = Date()
  
}

extension WDMTask {
  
  
  // TODO: needs to add ockscheule or ockscheduleleement instead instead of having frequency and occurence apart.
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
  
    public func getSchedule() -> OCKSchedule {
      var schedules: [OCKSchedule] = []
      if !taskRecurrence.frequency.isEmpty {
        for frequency in taskRecurrence.frequency {
          for occurence in taskRecurrence.occurence {
            schedules.append(OCKSchedule.weeklyAtTime(weekday: frequency.rawValue + 1, hours: get(occurence), minutes: 0, start: effectiveDate, end: nil, targetValues: [], text: title ?? "" + " " + occurence.rawValue.uppercased().localize()))
          }
        }
      } else {
        let scheduleElement = OCKScheduleElement(start: effectiveDate, end: effectiveDate, interval: DateComponents(day:0), text: title, targetValues: [], duration: .allDay)
        schedules.append(OCKSchedule(composing: [scheduleElement]))
      }
      
      return OCKSchedule(composing: schedules)
    }
}