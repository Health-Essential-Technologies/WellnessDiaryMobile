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
  
  public let graph: OCKGridTaskView
  
  // MARK: Initializers
  
  public init(with graph: OCKGridTaskView) {
    self.graph = graph
    super.init()
  }

}
