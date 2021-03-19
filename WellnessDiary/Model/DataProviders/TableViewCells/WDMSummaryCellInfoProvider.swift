//
//  WDMSummaryCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 3/7/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit

class WDMSummaryCellInfoProvider: WDMCellInfoProvider {
  
  // MARK: Properties
  
  public let chart: OCKCartesianChartView
  
  // MARK: Initializers
  
  public init(with chart: OCKCartesianChartView) {
    self.chart = chart
    super.init()
  }

}
