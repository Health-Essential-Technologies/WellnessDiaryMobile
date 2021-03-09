//
//  WDMStep.swift
//  WellnessDiary
//
//  Created by luis flores on 2/27/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import ResearchKit
import CareKit

public enum WDMDailyStepType: String, CaseIterable {
  
  case sleepTimeStep = "SLEEP_TIME"
  case sleepQualityStep = "SLEEP_QUALITY"
  case temperatureStep = "TEMPERATURE"
  case bloodPressureStep = "BLOOD_PRESSURE"
  case heartBeatStep = "HEART_BEAT"
  case weightStep = "WEIGHT"
  case bloodSugarStep = "BLOOD_SUGAR"
  case painLevelStep = "PAIN_LEVEL"
  
  // MARK: Properties
  private var sortOrder: Int {
    switch self {
    case .sleepTimeStep:
      return 0
    case .sleepQualityStep:
      return 1
    case .temperatureStep:
      return 2
    case .bloodPressureStep:
      return 3
    case .heartBeatStep:
      return 4
    case .weightStep:
      return 5
    case .bloodSugarStep:
      return 6
    case .painLevelStep:
      return 7
    }
  }
  
  public var key: String {
    return convertToKey()
  }
  
  public var switchTag: CellInfoProviderTag {
    switch self {
    case .sleepTimeStep:
      return .sleepTimeSwitchTag
    case .sleepQualityStep:
      return .sleepQualitySwitchTag
    case .temperatureStep:
      return .temperatureSwitchTag
    case .bloodPressureStep:
      return .bloodPressureSwitchTag
    case .heartBeatStep:
      return .heartBeatSwitchTag
    case .weightStep:
      return .weightSwitchTag
    case .bloodSugarStep:
      return .bloodSugarSwitchTag
    case .painLevelStep:
      return .painlevelSwitchTag
    }
  }
  
  private func convertToKey() -> String {
    return self.rawValue.lowercased() + "_" + "key"
  }
  
  public var chartType: OCKCartesianGraphView.PlotType {
    return OCKCartesianGraphView.PlotType.line
  }
  
}

extension WDMDailyStepType: Comparable {
  
  // MARK: Methods
  
  public static func < (lhs: WDMDailyStepType, rhs: WDMDailyStepType) -> Bool {
    return lhs.sortOrder < rhs.sortOrder
  }

}
  

public class WDMStep: ORKStep {

  // Properties
  
  public var stepType: WDMDailyStepType
  
  private var internalIsRestorable: Bool
  public override var isRestorable: Bool {
    return internalIsRestorable
  }
  
  // Initializers
  
  public init(with jsonDictionary: Dictionary<String,Any>) {
    let identifier = jsonDictionary["title"] as! String
    guard let type = WDMDailyStepType.init(rawValue: identifier),
          let restorable = jsonDictionary["restorable"] as? Bool,
          let optional = jsonDictionary["optional"] as? Bool,
          let text = jsonDictionary["text"] as? String else { fatalError("Unable to load identifier (\(identifier)) type from json dictionary.") }
    self.internalIsRestorable = restorable
    self.stepType = type
    super.init(identifier: type.rawValue)
    self.title = identifier.localize()
    self.text = text
    self.isOptional = optional
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
