//
//  CarePlanStoreManager.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import Foundation
import CareKit

enum TaskIdentifier: String, CaseIterable {
  case temperatureTest
  case bloodPressureTest
  case bloodSugarTest
}

final class CarePlanStoreManager {
  
  // MARK: - Properties
  
  static let sharedCarePlanStoreManager = CarePlanStoreManager()
  
  lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
    let store = OCKStore(name: "HealthDairy")
    let ssm = OCKSynchronizedStoreManager(wrapping: store)
    return ssm
  }()
  
  private let thisMorning = Calendar.current.startOfDay(for: Date())
  
  private let beforeBreakfast = 7
  private let afterBreakfast = 9
  private let beforeLunch = 11
  private let afterLunch = 13
  private let beforeDinner = 18
  private let afterDinner = 20
  
  // MARK: - Initializers
  
  private init() {}
  
  // MARK: - Methods
  
  private func get(_ occurence: TaskOccurence) -> Int {
    switch occurence {
    case .beforeBreakfast:
      return beforeBreakfast
    case .afterBreakfast:
      return afterBreakfast
    case .beforeLunch:
      return beforeLunch
    case .afterLunch:
      return afterLunch
    case .beforeDinner:
      return beforeDinner
    case .afterDinner:
      return afterDinner
    }
  }
  
  func addTask(with name: String, with startingDate: Date, taskFrequency: [TaskFrequency], taskOccurence: [TaskOccurence]) {
    var schedules: [OCKSchedule] = []
    if !taskFrequency.isEmpty {
      for frequency in taskFrequency {
        for occurence in taskOccurence {
          schedules.append(OCKSchedule.weeklyAtTime(weekday: frequency.rawValue + 1, hours: get(occurence), minutes: 0, start: startingDate, end: nil, targetValues: [], text: name + " " + occurence.getStringLocalize()))
        }
      }
    } else {
      let scheduleElement = OCKScheduleElement(start: startingDate, end: startingDate, interval: DateComponents(day:0), text: name, targetValues: [], duration: .allDay)
      schedules.append(OCKSchedule(composing: [scheduleElement]))
    }
    
    let task = OCKTask(id: UUID().uuidString, title: name, carePlanID: nil, schedule: OCKSchedule(composing: schedules))
    synchronizedStoreManager.store.addAnyTask(task, callbackQueue: .main) { results in
      
    }
  }
}

//let thisMorning = Calendar.current.startOfDay(for: Date())
//guard let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: thisMorning) else {
//  return
//}
//let endDay = Calendar.current.date(byAdding: .month, value: 12, to: thisMorning)!
//
//let bloodSugarSchedule = OCKSchedule(composing: [
//  OCKScheduleElement (start: beforeBreakfast,
//                     end: nil ,
//                     interval: DateComponents(day: 2),
//                     text: "Any time through the day",
//                     targetValues: [],
//                     duration: .allDay)
//])
//
//var bloodSugarTask = OCKTask(id: TaskIdentifier.bloodSugarTest.rawValue,
//                             title: "Diabetes Track",
//                             carePlanID: nil,
//                             schedule: bloodSugarSchedule)
//
//bloodSugarTask.instructions = "Use any aprove blood sugar meter"
////    bloodSugarTask.impactsAdherence = false
//addTask(bloodSugarTask)
