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
  
  var uniqueIdentifier: String = ""
  var title: String? = ""
  var taskRecurrence: (frequency: Set<TaskFrequency>, occurence: Set<TaskOccurence>) = (Set(TaskFrequency.allCases), Set(arrayLiteral: TaskOccurence.beforeBreakfast))
  var impactsAdherence: Bool = true
  var hasNotification: Bool = true
  var instructions: String? = ""
  var startDate: Date = Date()
 
  public var detailLabelFrequencyText: String {
    // NEEDS TO FIX FOR LOCALE
    if taskRecurrence.frequency.count == TaskFrequency.allCases.count {
      return "EVERY_DAY".localize()
    } else if taskRecurrence.frequency.isEmpty {
      return "NEVER".localize()
    } else if taskRecurrence.frequency.count == 1 {
      return "EVERY".localize() + " " + taskRecurrence.frequency.first!.description()
    } else {
      var str = ""
      taskRecurrence.frequency.sorted().forEach { str += $0.description() + ","}
      str.removeLast()
      return str
    }
  }
  
  public var detailLabelOccurenceText: String {
    return "TIMES_A_DAY".localize(comment: "Times of day a task is supposed to happen.", count: taskRecurrence.occurence.count)
  }
  
  // MARK: Initializers
  
  public init() { }
  
  public init(with task: OCKTask) {
    self.uniqueIdentifier = task.id
    self.title = task.title
    self.impactsAdherence = task.impactsAdherence
    self.hasNotification = (task.userInfo?[taskNotificationKey] != nil)
    self.instructions = task.instructions
    self.startDate = task.schedule.startDate()
    getTaskRecurrence(from: task)
  }
}

extension WDMTask {
  
  // MARK: Methods
  
    public func getSchedule() -> OCKSchedule {
      var schedules: [OCKSchedule] = []
      if !taskRecurrence.frequency.isEmpty {
        for frequency in taskRecurrence.frequency {
          for occurence in taskRecurrence.occurence {
            schedules.append(OCKSchedule.weeklyAtTime(weekday: frequency.rawValue + 1, hours: occurence.rawValue, minutes: 0, start: startDate, end: nil, targetValues: [], text: title ?? "" + " " + TaskOccurence.getTaskAsStringFrom(occurence).localize()))
          }
        }
      } else {
        let scheduleElement = OCKScheduleElement(start: startDate, end: startDate, interval: DateComponents(day:0), text: title, targetValues: [], duration: .allDay)
        schedules.append(OCKSchedule(composing: [scheduleElement]))
      }
      
      return OCKSchedule(composing: schedules)
    }
  
  private mutating func getTaskRecurrence(from task: OCKTask) {
    var hourComponent = DateComponents()
    var taskFrequency = Set<TaskFrequency>()
    var taskOccurence = Set<TaskOccurence>()
    
    task.schedule.elements.forEach { element in
      let currentOccurence = TaskOccurence.getOccurence(from: element.start)
      taskOccurence.insert(currentOccurence)
      hourComponent.hour = currentOccurence.rawValue
      let date = Calendar.current.date(byAdding: hourComponent, to: element.start)!
      taskFrequency.insert(TaskFrequency.getFrequency(from: date))
    }
    
    self.taskRecurrence.frequency = Set(taskFrequency.sorted())
    self.taskRecurrence.occurence = taskOccurence
  }
}

extension WDMTask: Equatable {
  public static func == (lhs: WDMTask, rhs: WDMTask) -> Bool {
    return lhs.uniqueIdentifier == rhs.uniqueIdentifier
  }
  
  
}
