//
//  WDMSummaryTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 3/7/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKitUI

class WDMSummaryTableViewCell: WDMSimpleTableViewCell {
  
  // MARK - Properties
  
  private var chart: OCKCartesianChartView?

  // MARK: Methods
  
  override func initialSetup() {
    guard let chart = chart else { return }
    contentView.addSubview(chart)
    chart.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      chart.topAnchor.constraint(equalTo: contentView.topAnchor),
      chart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      chart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      chart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
    
  }
  
  override func didSetcellInfoProvider() {
    guard let infoProvider = cellInfoProvider as? WDMSummaryCellInfoProvider else { return }
    chart = infoProvider.chart
    initialSetup()
  }

}
