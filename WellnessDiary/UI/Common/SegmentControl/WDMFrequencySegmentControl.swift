//
//  WDMFrequencySegmentControl.swift
//  WellnessDiary
//
//  Created by Luis Flores on 4/12/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMFrequencySegmentControl: WDMSimpleSegmentControl {
  
  // MARK: Initializers

  public init() {
    super.init(items: [])
    insertSegment(withTitle: DailySurveySummaryFrequencySegmentSelected.lastSevenDays.title .localize(), at: DailySurveySummaryFrequencySegmentSelected.lastSevenDays.segmentControlIndex(), animated: true)
    insertSegment(withTitle: DailySurveySummaryFrequencySegmentSelected.lastThirtyDays.title.localize(), at: DailySurveySummaryFrequencySegmentSelected.lastThirtyDays.segmentControlIndex(), animated: true)
    insertSegment(withTitle: DailySurveySummaryFrequencySegmentSelected.lastNinetyDays.title.localize(), at: DailySurveySummaryFrequencySegmentSelected.lastNinetyDays.segmentControlIndex(), animated: true)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = Colors.mainColor.color
    setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
    setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Colors.mainColor.color], for: .selected)
    selectedSegmentIndex = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
