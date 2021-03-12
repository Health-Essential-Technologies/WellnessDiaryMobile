//
//  OCKStore+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import Foundation
import CareKit

extension OCKStore {
  
  // MARK: - Methods
  
  func populateDailyTask() {
    let thisMorning = Calendar.current.startOfDay(for: Date())
    guard let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: thisMorning) else {
      return
    }
    let endDay = Calendar.current.date(byAdding: .month, value: 12, to: thisMorning)!
    
    let bloodSugarSchedule = OCKSchedule(composing: [
      OCKScheduleElement (start: beforeBreakfast,
                         end: nil ,
                         interval: DateComponents(day: 2),
                         text: "Any time through the day",
                         targetValues: [],
                         duration: .allDay)
    ])
    
    var bloodSugarTask = OCKTask(id: TaskIdentifier.bloodSugarTest.rawValue,
                                 title: "Diabetes Track",
                                 carePlanID: nil,
                                 schedule: bloodSugarSchedule)
    
    bloodSugarTask.instructions = "Use any aprove blood sugar meter"
//    bloodSugarTask.impactsAdherence = false
    addTask(bloodSugarTask)
  }
  
}
