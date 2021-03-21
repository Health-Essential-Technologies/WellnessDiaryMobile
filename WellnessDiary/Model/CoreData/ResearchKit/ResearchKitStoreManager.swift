//
//  ResearchKitStoreManager.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit
import CoreData

final class ResearchKitStoreManager {
  
  // MARK: Properties
  
  public static let shared = ResearchKitStoreManager()
  private let store = WDMStore(name: "RKWellnessDiary")
  
  private var dailySurveys: [WDMCDSurvey] = []
  private var isNewDay = false
  
  // MARK: Initializers
  
  private init() {
    NotificationCenter.default.addObserver(self, selector: #selector(calendarDayChanged), name: .NSCalendarDayChanged, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(calendarDayChanged), name: .surveyAdded, object: nil)
  }
  
  // MARK: Methods
  
  public func addSurvey(from taskResult: ORKTaskResult) {
    
    var sleepQuantity: Double?
    var sleepQuality: Int?
    var temperature: Double?
    var bloodPressure: String?
    var hearthBeat: Int?
    var weight: Double?
    var bloodSugar: Int?
    var painLevel: Int?
    
    if let sleepTimeResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.sleepTimeStep.rawValue) {
      if let result = sleepTimeResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Double {
        sleepQuantity = answer
      }
    }
    
    if let sleepQualityResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.sleepQualityStep.rawValue) {
      if let result = sleepQualityResult.firstResult as? ORKScaleQuestionResult, let answer = result.answer as? Int {
        sleepQuality = answer
      }
    }
    
    if let temperatureResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.temperatureStep.rawValue) {
      if let result = temperatureResult.firstResult as? ORKNumericQuestionResult {
        if let answer = result.answer as? Double {
          temperature = answer
        }
      }
    }
    
    if let bloodPressureResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.bloodPressureStep.rawValue) {
      if let result = bloodPressureResult.firstResult as? ORKTextQuestionResult, let answer = result.answer as? String {
        bloodPressure = answer
      }
    }
    
    if let heartBeatResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.heartBeatStep.rawValue) {
      if let result = heartBeatResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Int {
        hearthBeat = answer
      }
    }
    
    if let weightResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.weightStep.rawValue) {
      if let result = weightResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Double {
        weight = answer
      }
    }
    
    if let sugarLevelResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.bloodSugarStep.rawValue) {
      if let result = sugarLevelResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Int {
        bloodSugar = answer
      }
    }
    
    if let painLevelResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.painLevelStep.rawValue) {
      if let result = painLevelResult.firstResult as? ORKScaleQuestionResult, let answer = result.answer as? Int {
        painLevel = answer
      }
    }
    
    addSurvey(withSleepQuantity: sleepQuantity, sleepQuality: sleepQuality, temperature: temperature, bloodPressure: bloodPressure, heartBeat: hearthBeat, weight: weight, sugarLevel: bloodSugar, painLevel: painLevel)
  }
  
  /// Primary use of this method is to load mock data. Need to save and post notification afterwards.
  public func addSurvey(fromDictionary dictionary: [String:Any], date: Date) {
    addSurvey(withSleepQuantity: dictionary[WDMDailyStepType.sleepTimeStep.rawValue] as? Double, sleepQuality: dictionary[WDMDailyStepType.sleepQualityStep.rawValue] as? Int, temperature: dictionary[WDMDailyStepType.temperatureStep.rawValue] as? Double, bloodPressure: dictionary[WDMDailyStepType.bloodPressureStep.rawValue] as? String, heartBeat: dictionary[WDMDailyStepType.heartBeatStep.rawValue] as? Int, weight: dictionary[WDMDailyStepType.weightStep.rawValue] as? Double, sugarLevel: dictionary[WDMDailyStepType.bloodSugarStep.rawValue] as? Int, painLevel: dictionary[WDMDailyStepType.painLevelStep.rawValue] as? Int, date: date, persist: false, notify: false )
  }
  
  private func addSurvey(withSleepQuantity sleepQuantity: Double?, sleepQuality: Int?, temperature: Double?, bloodPressure: String?, heartBeat: Int?, weight: Double?, sugarLevel: Int?, painLevel: Int?, date: Date = Date(), persist: Bool = true, notify: Bool = true) {
    
    let today = date
  
    let survey = WDMCDSurvey(context: store.customResearchKitContext)
    survey.createdDate = today
    
    if let sleepQuantity = sleepQuantity {
      survey.sleepQuantityStep = store.addSleepQuantity(with: sleepQuantity, createdDate: today)
    }
    
    if let sleepQuality = sleepQuality {
      survey.sleepQualityStep = store.addSleepQuality(with: sleepQuality, createdDate: today)
    }
    
    if let temperature = temperature {
      survey.temperatureStep = store.addTemperature(with: temperature, createdDate: today)
    }
    
    if let bloodPressure = bloodPressure {
      let splitAnswer = bloodPressure.components(separatedBy: "/")
      if let splitAnswerFirst = splitAnswer.first, let splitAnswerLast = splitAnswer.last, let systolicValue = Int(splitAnswerFirst), let distolicValue = Int(splitAnswerLast) {
        survey.bloodPressureStep = store.addBloodPressure(withsystolicValue: systolicValue, diastolicValue: distolicValue, createdDate: today)
      }
    }
    if let heartBeat = heartBeat {
      survey.heartBeatStep = store.addHeartBeat(with: heartBeat, createdDate: today)
    }
    if let weight = weight {
      survey.weightStep = store.addWeight(with: weight, createdDate: today)
    }
    
    if let sugarLevel = sugarLevel {
      survey.sugarLevelStep = store.addBloodSugar(with: sugarLevel, createdDate: today)
    }
    
    if let painLevel = painLevel {
      survey.painLevelStep = store.addPainLevel(with: painLevel, createdDate: today)
    }

    
    if persist {
      saveContext()
    }
    
    if notify {
      NotificationCenter.default.post(name: .surveyAdded, object: nil)
    }
    
  }
  
  public func saveContext() {
    self.store.save()
  }
  
  public func fetchSurvey(with selectedSegment: DailySurveySummaryFrequencySegmentSelected = .lastNinetyDays) -> [WDMCDSurvey]? {
    return fetchSurvey(with: selectedSegment, forceFetch: false)
  }
  
  @discardableResult
  public func fetchSurvey(with selectedSegment: DailySurveySummaryFrequencySegmentSelected, forceFetch: Bool) -> [WDMCDSurvey]? {
    if !dailySurveys.isEmpty && forceFetch == false {
      return getDailySurvey(for: selectedSegment)
    }
    
    store.customResearchKitContext.performAndWait {
      let fetchRequest = WDMCDSurvey.fetchRequest(with: selectedSegment)
      do {
        dailySurveys =  try fetchRequest.execute()
      } catch {
        print("Unable to fetch surveys. Error: \(error.localizedDescription)")
      }
    }
    
    return getDailySurvey(for: selectedSegment)
  }
  
  @objc private func calendarDayChanged() {
    self.fetchSurvey(with: .lastNinetyDays, forceFetch: true)
  }
  
  private func getDailySurvey(for selectedSegment: DailySurveySummaryFrequencySegmentSelected) -> [WDMCDSurvey]? {
    
    var selectedSegmentSurveys: [WDMCDSurvey]
    
    if dailySurveys.count < selectedSegment.rawValue {
      selectedSegmentSurveys = dailySurveys
    } else {
      selectedSegmentSurveys = Array(dailySurveys[0..<selectedSegment.rawValue])
    }
    return selectedSegmentSurveys.reversed()
  }
  
  public func clearDailySurveys() {
    store.clearResearchKitStore(withObjects: dailySurveys)
    dailySurveys.removeAll()
    NotificationCenter.default.post(name: .surveyAdded, object: nil)
  }
  
}
