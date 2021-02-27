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
  var taskRecurrence: WDMTaskReccurence = WDMTaskReccurence()
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
  
  private var dateFormatter: DateFormatter = {
    var df = DateFormatter()
    df.dateStyle = .full
    return df
  }()
  
  // MARK: Initializers
  
  public init(_ startDate: Date) {
    self.uniqueIdentifier = UUID().uuidString
    self.startDate = startDate
  }
  
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
            schedules.append(OCKSchedule.weeklyAtTime(weekday: frequency.rawValue, hours: occurence.rawValue, minutes: 0, start: Calendar.current.startOfDay(for: startDate), end: nil, targetValues: [], text: title ?? "" + " " + TaskOccurence.getTaskAsStringFrom(occurence).localize()))
          }
        }
      } else {
        let scheduleElement = OCKScheduleElement(start: startDate, end: startDate, interval: DateComponents(day:0), text: title, targetValues: [], duration: .allDay)
        schedules.append(OCKSchedule(composing: [scheduleElement]))
      }
      
      return OCKSchedule(composing: schedules)
    }
  
  private mutating func getTaskRecurrence(from task: OCKTask) {
    taskRecurrence.frequency.removeAll()
    taskRecurrence.occurence.removeAll()
    
    task.schedule.elements.forEach { element in
      self.taskRecurrence.occurence.insert(TaskOccurence.getOccurence(from: element.start))
      self.taskRecurrence.frequency.insert(TaskFrequency.getFrequency(from: element.start))
    }
    
    self.taskRecurrence.frequency = Set(self.taskRecurrence.frequency.sorted())
  }
  
}

// MARK: Equatable

extension WDMTask: Equatable {
  public static func == (lhs: WDMTask, rhs: WDMTask) -> Bool {
    return lhs.uniqueIdentifier == rhs.uniqueIdentifier
  }
  
  
}

extension WDMTask {
  
  // MARK: Methods
  
  static func getNotificationIdentifier(with uniqueIdentifier: String, with frequency: TaskFrequency, with occurence: TaskOccurence) -> String {
   return uniqueIdentifier + "_" + frequency.description() + "_" + TaskOccurence.getTaskAsStringFrom(occurence)
  }
  
}
