//
//  OCKCartesianChartView + Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 3/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import CareKit

extension OCKCartesianChartView {
  
  public func setXAxisLabels(from selectedSegment: DailySurveySummaryFrequencySegmentSelected) {
    switch selectedSegment {
    case .lastSevenDays:
      graphView.horizontalAxisMarkers = ["1","2","3","4","5","6","7"]
      break
    case .lastThirtyDays:
      graphView.horizontalAxisMarkers = ["1","5","10","15","20","25","30"]
    case .lastNinetyDays:
      graphView.horizontalAxisMarkers = ["1","15","30","45","60","75","90"]
    }
  }
}
