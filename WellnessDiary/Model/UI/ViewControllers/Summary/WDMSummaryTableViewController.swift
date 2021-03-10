//
//  WDMSummaryTableViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 3/4/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit

public enum DailySurveySummaryFrequencySegmentSelected: Int {
  case lastSevenDays
  case lastThirtyDays
  case lastNinetyDays
}

class WDMSummaryTableViewController: WDMSimpleTableViewController {
  
  // MARK: Properties
  
  private var frequencySegment: WDMSimpleSegmentControl = {
    let segment = WDMSimpleSegmentControl()
    segment.insertSegment(withTitle: "LAST_7_DAYS".localize(), at: DailySurveySummaryFrequencySegmentSelected.lastSevenDays.rawValue, animated: true)
    segment.insertSegment(withTitle: "LAST_30_DAYS".localize(), at: DailySurveySummaryFrequencySegmentSelected.lastThirtyDays.rawValue, animated: true)
    segment.insertSegment(withTitle: "LAST_90_DAYS".localize(), at: DailySurveySummaryFrequencySegmentSelected.lastNinetyDays.rawValue, animated: true)
    segment.translatesAutoresizingMaskIntoConstraints = false
    segment.backgroundColor = Colors.mainColor.color
    let color = NSAttributedString()
    segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
    segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Colors.mainColor.color], for: .selected)
    segment.selectedSegmentIndex = 0
    return segment
  }()

  // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // MARK: Methods
  
  override func initialSetup() {
    
//    let chartView = OCKCartesianChartView(type: .line)
//    chartView.translatesAutoresizingMaskIntoConstraints = false
//    chartView.headerView.titleLabel.text = "Doxylamine"
//
//    var series: OCKDataSeries = OCKDataSeries(values: [0, 1, 1, 2, 3, 3, 2], title: "Doxylamine")
//
//    chartView.graphView.dataSeries = [series]
//    
//    view.addSubview(chartView)
//
//    var value = [CGFloat]()
//
//
//    for i in 1...90 {
//      value.append(CGFloat(i))
//      if i % 30 == 0 ||  i == 1 {
//        chartView.graphView.horizontalAxisMarkers.append("\(i) days")
//      }
//    }
//
//    value.shuffle()
//    chartView.graphView.yMinimum = 10
//    chartView.graphView.yMaximum = 200
//    series = OCKDataSeries(values: value, title: "something")
//    series.size = 1
//    chartView.graphView.dataSeries = [series]
//    chartView.headerView.detailLabel.text = "well this is details"
//
//    NSLayoutConstraint.activate([
//      chartView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//      chartView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
//    ])
//    
//    return
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    
    title = "SUMMARY".localize()
    
    view.addSubview(tableView)
    view.addSubview(frequencySegment)
    
    NSLayoutConstraint.activate([
      
      frequencySegment.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8),
      frequencySegment.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      frequencySegment.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: frequencySegment.bottomAnchor, constant: 8),
      tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
    ])
    
    tableView.dataSource = tableViewDataSourceHandler
    tableView.delegate = tableviewDelegateHandler
    
    frequencySegment.addTarget(self, action: #selector(frequencySegmentTapped(_:)), for: .valueChanged)
    infoProvider = createInfoProvider()
    
  }
  
  override func createInfoProvider() -> WDMTableViewInfoProvider {
    
    var sectionItems = [TableViewSectionItem]()
    WDMDailyStepType.allCases.forEach {
      let infoProvider = WDMSummaryCellInfoProvider(with: $0.chartType)
      let row = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: infoProvider, cellType: WDMSummaryTableViewCell.self)
      sectionItems.append(TableViewSectionItem(headerTitle: $0.rawValue.localize(), footerTitle: nil, sectionRowItems: [row]))
      
    }
    return WDMSummaryInfoProvider(withSectionItems: sectionItems, presenterViewController: self)
  }
  
  @objc private func frequencySegmentTapped(_ segmentControl: WDMSimpleSegmentControl) {
//    switch segmentControl.selectedSegmentIndex {
//    case FrequencySegmentSelected.weekly.rawValue:
//      // Refresh for weekly
//    return
//    case FrequencySegmentSelected.monthly.rawValue:
//      // Refresh for monthly
//    return
//    default:
//      // Does nothing
//    return
//    }
  }

}
