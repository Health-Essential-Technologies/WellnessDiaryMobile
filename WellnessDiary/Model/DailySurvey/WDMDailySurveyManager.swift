//
//  WDMDailySurveyManager.swift
//  WellnessDiary
//
//  Created by luis flores on 2/27/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import ResearchKit
import CareKitUI

class WDMDailySurveyManager: NSObject {
  
  static public let sharedInstance = WDMDailySurveyManager()

  // MARK: Properties
  
  public lazy var introStep: ORKInstructionStep = {
    let intro = ORKInstructionStep(identifier: "intro")
    intro.title = "DAILY_SURVEY".localize()
    intro.text = "THIS_SURVEY_ITS_AIMED_AT_HELPING_YOU_RECORD_VITAL_SIGNS_IN_ORDER_TO_FURTHER_HELP_YOUR_HEALTHCARE_PROVIDER,_AS_WELL_AS_YOURSELF,_WITH_INSIGHT_INFORMATION_OF_YOUR_DAILY_VITALS,_WHICH_WIL_RESULT_IN_NOTICING_A_DOWNARD_TREND_IN_YOUR_HEALTH_AND_ACT_ACCORDINGLY.\n\n\nREST_ASSURE_THAT_YOUR_INFORMATION_IS_NEVER_SAVED_IN_ANY_WEB_SERVER_AND_THAT_IT_IS_SAFELY_SECURE_BY_YOUR_OWN_DEVICE_ENCRYPTION_TECHNOLOGY_AND_THAT_NONE_OF_YOUR_DATA_IS_EVER_SOLD.\n\nYOU_CAN_SKIP_ANY_QUESTION,_BUT_THE_MORE_INFORMATION_YOU_PROVIDE,_THE_BETTER_WILL_BE_FOR_YOU_AND_YOUR_DOCTOR_TO_DETERMINE_MEANINGFUL_CHANGES_IN_YOUR_HEALTH.".localize()
    return intro
  }()
  
  public lazy var sleepTimeStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.sleepTimeStep.rawValue, title: WDMDailyStepType.sleepTimeStep.rawValue.localize(), question: "HOW_MANY_HOURS_OF_SLEEP_DID_YOU-GET_LAST_NIGHT_?".localize(), answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "HOURS".localize()))
  }()
  
  public lazy var sleepQualityStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.sleepQualityStep.rawValue, title: WDMDailyStepType.sleepQualityStep.rawValue.localize(), question: "ON_A_SCALE_OF_1_TO_10_,_HOW_WAS_YOUR_SLEEP_QUALITY?".localize(), answer: ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 8, step: 1, vertical: false, maximumValueDescription: "EXCELLENT".localize(), minimumValueDescription: "POOR".localize()))
  }()
  
  public lazy var temperatureStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.temperatureStep.rawValue, title: WDMDailyStepType.temperatureStep.rawValue.localize(), question: "WHAT_IS_YOUR_BODY_TEMPERATURE_?".localize(), answer: ORKAnswerFormat.decimalAnswerFormat(withUnit: "F"))
  }()
  
  public lazy var bloodPressureStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.bloodPressureStep.rawValue, title: WDMDailyStepType.bloodPressureStep.rawValue.localize(), question: "WHAT_IS_YOUR_BLOOD_PRESSURE_?".localize(), answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "mmHg"))
  }()
  
  public lazy var heartBeatStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.heartBeatStep.rawValue, title: WDMDailyStepType.heartBeatStep.rawValue.localize(), question: "WHAT_IS_YOUR_HEART_BEAT_?".localize(), answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "BPM"))
  }()
  
  public lazy var weightStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.weightStep.rawValue, title: WDMDailyStepType.weightStep.rawValue.localize(), question: "WHAT_IS_YOUR_BODY_WEIGHT_?".localize(), answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "lbs"))
  }()
  
  public lazy var bloodSugarStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.bloodSugarStep.rawValue, title: WDMDailyStepType.bloodSugarStep.rawValue.localize(), question: "WHAT_IS_YOUR_BLOOD_SUGAR_LEVEL_?".localize(), answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "mg/dL"))
  }()
  
  public lazy var painLevelStep: ORKQuestionStep = {
    return ORKQuestionStep(identifier: WDMDailyStepType.painLevelStep.rawValue, title: WDMDailyStepType.painLevelStep.rawValue.localize(), question: "ON_A_SCALE_OF_1_TO_10_,_WHAT_IS_YOUR_PAIN_LEVEL_?".localize(), answer: ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 0, defaultValue: 5, step: 1, vertical: false, maximumValueDescription: "UNTOLERABLE".localize(), minimumValueDescription: "NO_PAIN".localize()))

  }()
  public func getDailySurvey() -> ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.sleepTimeStep.key) {
      steps.append(sleepTimeStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.sleepQualityStep.key) {
      steps.append(sleepQualityStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.temperatureStep.key) {
      steps.append(temperatureStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.bloodPressureStep.key) {
      steps.append(bloodPressureStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.heartBeatStep.key) {
      steps.append(heartBeatStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.weightStep.key) {
      steps.append(weightStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.bloodSugarStep.key) {
      steps.append(bloodSugarStep)
    }
    
    if UserPreference.sharedUserPreferences.getBool(for: WDMDailyStepType.painLevelStep.key) {
      steps.append(painLevelStep)
    }
    
    if steps.count > 0 {
      steps.insert(introStep, at: 0)
    }
    
    return ORKOrderedTask(identifier: "identifier", steps: steps)

  }
 
  // MARK: Initializers
  
  private override init() { }
  
  // MARK: Methods
  
  public func getSleepTimeChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getSleepQualityChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getTemperatureChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getBloodPressureChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getHeartBeatChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getWeightChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getBloodSugarChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  public func getPainLevelChart(for frequency: DailySurveySummaryFrequencySegmentSelected) -> OCKCartesianChartView {
    let  chart = OCKCartesianChartView(type: .line)
    return chart
  }
  
  
}
