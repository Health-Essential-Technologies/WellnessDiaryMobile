//
//  DailySurveySummaryFrequencySegmentSelected.swift
//  WellnessDiary
//
//  Created by Luis Flores on 4/12/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation

public enum DailySurveySummaryFrequencySegmentSelected: Int {

  // MARK: Cases
  
  case lastSevenDays = 7
  case lastThirtyDays = 30
  case lastNinetyDays = 90
  
  // MARK: Properties
  
  public var title: String {
    switch self {
    case .lastSevenDays:
      return "LAST_7_DAYS"
    case .lastThirtyDays:
      return "LAST_30_DAYS"
    case .lastNinetyDays:
      return "LAST_90_DAYS"
    }
  }
  
  // MARK: Methods
  
  public static func getDailySurveySummaryFrequencySegmentSelected(from segmentIndex: Int) -> DailySurveySummaryFrequencySegmentSelected {
    switch segmentIndex {
    case 1:
      return .lastThirtyDays
    case 2:
      return .lastNinetyDays
    default:
      return .lastSevenDays
    }
  }
  
  public func segmentControlIndex() -> Int {
    switch self {
    case .lastSevenDays:
      return 0
    case .lastThirtyDays:
      return 1
    case .lastNinetyDays:
      return 2
    }
  }

}
