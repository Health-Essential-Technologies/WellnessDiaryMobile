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
    
    let today = Date()
  
    let survey = WDMCDSurvey(context: store.customResearchKitContext)
    survey.createdDate = today
    
    if let sleepTimeResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.sleepTimeStep.rawValue) {
      if let result = sleepTimeResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Float {
        survey.sleepQuantityStep = store.addSleepQuantity(with: answer, createdDate: today)
      }
    }
    
    if let sleepQualityResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.sleepQualityStep.rawValue) {
      if let result = sleepQualityResult.firstResult as? ORKScaleQuestionResult, let answer = result.answer as? Int {
        survey.sleepQualityStep = store.addSleepQuality(with: answer, createdDate: today)
      }
    }
    
    if let temperatureResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.temperatureStep.rawValue) {
      if let result = temperatureResult.firstResult as? ORKNumericQuestionResult {
        if let answer = result.answer as? Double {
          survey.temperatureStep = store.addTemperature(with: Float(answer), createdDate: today)
        }
      }
    }
    
    if let bloodPressureResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.bloodPressureStep.rawValue) {
      if let result = bloodPressureResult.firstResult as? ORKTextQuestionResult, let answer = result.answer as? String {
        let splitAnswer = answer.components(separatedBy: "/")
        if let splitAnswerFirst = splitAnswer.first, let splitAnswerLast = splitAnswer.last, let systolicValue = Int(splitAnswerFirst), let distolicValue = Int(splitAnswerLast) {
          survey.bloodPressureStep = store.addBloodPressure(withsystolicValue: systolicValue, diastolicValue: distolicValue, createdDate: today)
        }
      }
    }
    
    if let heartBeatResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.heartBeatStep.rawValue) {
      if let result = heartBeatResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Float {
        survey.heartBeatStep = store.addHeartBeat(with: answer, createdDate: today)
      }
    }
    
    if let weightResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.weightStep.rawValue) {
      if let result = weightResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Float {
        survey.weightStep = store.addWeight(with: answer, createdDate: today)
      }
    }
    
    if let sugarLevelResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.bloodSugarStep.rawValue) {
      if let result = sugarLevelResult.firstResult as? ORKNumericQuestionResult, let answer = result.answer as? Float {
        survey.sugarLevelStep = store.addBloodSugar(with: answer, createdDate: today)
      }
    }
    
    if let painLevelResult = taskResult.stepResult(forStepIdentifier: WDMDailyStepType.painLevelStep.rawValue) {
      if let result = painLevelResult.firstResult as? ORKScaleQuestionResult, let answer = result.answer as? Int {
        survey.painLevelStep = store.addPainLevel(with: answer, createdDate: today)
      }
    }
    
    store.save()
    NotificationCenter.default.post(name: .surveyAdded, object: nil)
  }
  
  public func fetchSurvey(with selectedSegment: DailySurveySummaryFrequencySegmentSelected = .lastNinetyDays) -> [WDMCDSurvey]? {
    return fetchSurvey(with: selectedSegment, forceFetch: false)
  }
  
  @discardableResult
  public func fetchSurvey(with selectedSegment: DailySurveySummaryFrequencySegmentSelected, forceFetch: Bool) -> [WDMCDSurvey]? {
    if !dailySurveys.isEmpty && forceFetch == false {
      return getDailySurvey(for: selectedSegment)
    }
    
    let fetchRequest = WDMCDSurvey.fetchRequest(with: selectedSegment)
    do {
      dailySurveys =  try store.customResearchKitContext.fetch(fetchRequest)
      return getDailySurvey(for: selectedSegment)
    } catch {
      print("Unable to fetch surveys. Error: \(error.localizedDescription)")
      return nil
    }
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
  
  
}
