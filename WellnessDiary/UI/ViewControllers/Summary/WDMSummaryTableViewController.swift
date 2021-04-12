//
//  WDMSummaryTableViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 3/4/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit

class WDMSummaryTableViewController: WDMSimpleTableViewController {
  
  // MARK: Properties
  
  private var frequencySegment = WDMFrequencySegmentControl()
  
  private var lastSevenDaysAvg: CGFloat = -1.0
  private var lastNinetyDaysAvg: CGFloat = -1.0
  private var lastThirtyDaysAvg: CGFloat = -1.0
  
  // MARK: Sections
  
  private let learnMoreText = "LEARN_MORE".localize()
  
  // MARK: Charts
  
  private let sleepTimeChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  private let sleepQualityChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  private let temperatureChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  private let bloodPressureChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .bar)
    return chart
  }()
  
  private let heartBeatChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  private let weightChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  private let sugarLevelChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  private let painLevelChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  

  // MARK: Lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
      NotificationCenter.default.addObserver(self, selector: #selector(surveyAdded(notification:)), name: .surveyAdded, object: nil)
    }
  
  // MARK: Methods
  
  override func initialSetup() {
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    tableView.register(WDMSummaryLearnMoreFooterView.self, forHeaderFooterViewReuseIdentifier: WDMSummaryLearnMoreFooterView.reuseIdentifier)
    
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
  
  private func clearData(withChart chart: OCKCartesianChartView) {
    chart.graphView.dataSeries.removeAll()
    chart.headerView.detailLabel.text = ""

  }
  
  private func loadChartData() {
    
    let selectedSegment = DailySurveySummaryFrequencySegmentSelected.getDailySurveySummaryFrequencySegmentSelected(from: frequencySegment.selectedSegmentIndex)
    
    let charts =    [sleepTimeChart, sleepQualityChart, temperatureChart, bloodPressureChart, heartBeatChart, weightChart, sugarLevelChart, painLevelChart]
    
    charts.forEach {
      clearData(withChart: $0)
    }
    
    guard let surveys = ResearchKitStoreManager.shared.fetchSurvey(with: selectedSegment) else { return }
    
    charts.forEach { chart in
      chart.graphView.xMinimum = 1
      chart.graphView.xMaximum = CGFloat(selectedSegment.rawValue)
      chart.setXAxisLabels(from: selectedSegment)
    }

    let dataSeriesSize: CGFloat = 1.5
    
    var sleepQuantityDataSeries = OCKDataSeries(values: [], title: "SLEEP_TIME_QUANTITY_PER_DAY".localize())
    sleepQuantityDataSeries.size = dataSeriesSize
  
    var sleepQualityDataSeries = OCKDataSeries(values: [], title: "SLEEP_QUALITY_PER_DAY".localize())
    sleepQualityDataSeries.size = dataSeriesSize
    
    var temperatureDataSeries = OCKDataSeries(values: [], title: "TEMPERATURE_LEVELS_PER_DAY".localize())
    temperatureDataSeries.size = dataSeriesSize
    
    var bpSize = dataSeriesSize
    if selectedSegment == .lastNinetyDays {
      bpSize = 0.5
    }
    
    var bloodPressureSystolicDataSeries = OCKDataSeries(values: [], title: "SYSTOLIC_LEVELS_PER_DAY".localize())
    bloodPressureSystolicDataSeries.size = bpSize
    	
    var bloodPressureDiastolicDataSeries = OCKDataSeries(values: [], title: "DIASTOLIC_LEVELS_PER_DAY".localize(), color: .red)
    bloodPressureDiastolicDataSeries.size = bpSize
    
    var heartBeatDataSeries = OCKDataSeries(values: [], title: "HEART_BEAT_RATE_PER_DAY".localize())
    heartBeatDataSeries.size = dataSeriesSize
    
    var weightDataSeries = OCKDataSeries(values: [], title: "WEIGHT_PER_DAY".localize())
    weightDataSeries.size = dataSeriesSize
    
    var sugarLevelDataSeries = OCKDataSeries(values: [], title: "SUGAR_LEVELS_PER_DAY".localize())
    sugarLevelDataSeries.size = dataSeriesSize
    
    var painLevelDataSeries = OCKDataSeries(values: [], title: "PAIN_LEVELS_PER_DAY".localize())
    painLevelDataSeries.size = dataSeriesSize
    
    var day = 0
    
    surveys.enumerated().forEach {
      
      day += 1
      
      if let sleepQuantity = $1.sleepQuantityStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(sleepQuantity.value))
        sleepQuantityDataSeries.dataPoints.append(point)
        sleepTimeChart.graphView.dataSeries = [sleepQuantityDataSeries]
      }
      
      if let sleepQuality = $1.sleepQualityStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(sleepQuality.value))
        sleepQualityDataSeries.dataPoints.append(point)
        sleepQualityChart.graphView.dataSeries = [sleepQualityDataSeries]
      }
      
      if let temperature = $1.temperatureStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(temperature.value))
        temperatureDataSeries.dataPoints.append(point)
        temperatureChart.graphView.dataSeries = [temperatureDataSeries]
      }
      
      // Need to do systolic
      if let bloodPressure = $1.bloodPressureStep {
        let systolicPoint = CGPoint(x: CGFloat(day), y: CGFloat(bloodPressure.systolicValue))
        bloodPressureSystolicDataSeries.dataPoints.append(systolicPoint)
        
        let diastolicPoint = CGPoint(x: CGFloat(day), y: CGFloat(bloodPressure.diastolicValue))
        bloodPressureDiastolicDataSeries.dataPoints.append(diastolicPoint)
        bloodPressureChart.graphView.dataSeries = [bloodPressureSystolicDataSeries,bloodPressureDiastolicDataSeries]
      }
      
      if let heartBeat = $1.heartBeatStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(heartBeat.value))
        heartBeatDataSeries.dataPoints.append(point)
        heartBeatChart.graphView.dataSeries = [heartBeatDataSeries]
      }
      
      if let weight = $1.weightStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(weight.value))
        weightDataSeries.dataPoints.append(point)
        weightChart.graphView.dataSeries = [weightDataSeries]
      }
      
      if let sugarLevel = $1.sugarLevelStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(sugarLevel.value))
        sugarLevelDataSeries.dataPoints.append(point)
        sugarLevelChart.graphView.dataSeries = [sugarLevelDataSeries]
      }
      
      if let painLevel = $1.painLevelStep {
        let point = CGPoint(x: CGFloat(day), y: CGFloat(painLevel.value))
        painLevelDataSeries.dataPoints.append(point)
        painLevelChart.graphView.dataSeries = [painLevelDataSeries]
        
      }
      
    }
    
    // Averages calculations
    charts.forEach {
      if let dataSeries = $0.graphView.dataSeries.first {
        let dataSeriesCount = dataSeries.dataPoints.count
        if dataSeriesCount > 1 {
          let dataSeriesSum = dataSeries.dataPoints.compactMap{$0}.reduce(into: CGPoint()) { result, point in result.y += point.y }.y
          let dataSeriesAverage = Int(round(Double(dataSeriesSum) / Double(dataSeriesCount)))
          
          switch $0 {
          
          case sleepTimeChart:
              $0.headerView.detailLabel.text = "YOUR_AVERAGE_SLEEP_TIME_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          case sleepQualityChart:
            $0.headerView.detailLabel.text = "YOUR_AVERAGE_SLEEP_QUALITY_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          case temperatureChart:
            $0.headerView.detailLabel.text = "YOUR_AVERAGE_BODY_TEMPERATURE_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          case bloodPressureChart:
            $0.headerView.detailLabel.text = "YOUR_SYSTOLIC_AVERAGE_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            $0.headerView.detailLabel.text?.append("\n" + "YOUR_DIASTOLIC_AVERAGE_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)")
            break
          case heartBeatChart:
            $0.headerView.detailLabel.text = "YOUR_AVERAGE_HEART_BEAT_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          case weightChart:
            $0.headerView.detailLabel.text = "YOUR_AVERAGE_WEIGHT_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          case sugarLevelChart:
            $0.headerView.detailLabel.text = "YOUR_AVERAGE_BLOOD_SUGAR_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          case painLevelChart:
            $0.headerView.detailLabel.text = "YOUR_AVERAGE_PAIN_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            break
          default:
            break
          }
        }
      }
    }

    // Set the minimums for each graph
    
    charts.forEach {
      $0.graphView.yMinimum = $0.graphView.dataSeries.first?.dataPoints.min { a, b in a.y < b.y }?.y
      
      let yMinimum = $0.graphView.yMinimum ?? 0
      let yMaximum = $0.graphView.dataSeries.first?.dataPoints.min { a, b in a.y > b.y }?.y ?? 0
      
      if $0 == sugarLevelChart || $0 == weightChart || $0 == heartBeatChart {
        $0.graphView.yMinimum = yMinimum - 5
        $0.graphView.yMaximum = yMaximum + 5
      } else if $0 == bloodPressureChart {
        $0.graphView.yMinimum = 0
      }else if $0 == painLevelChart || $0 == temperatureChart || $0 == sleepQualityChart {
        $0.graphView.yMinimum = yMinimum - 1
        $0.graphView.yMaximum = yMaximum + 1
      }
    }
  }
  
  override func createInfoProvider() -> WDMTableViewInfoProvider {

    loadChartData()
    
    var sectionItems = [TableViewSectionItem]()
    
    // ---Sleep Time Quantity---
    
      var learnMoreURL = URL(string: "https://mantasleep.com/blogs/sleep/sleep-quantity-vs-sleep-quality-which-one-makes-the-biggest-difference")
    let learnMoreStr = "LEARN_MORE".localize()
    
    let sleepTimeInfoProvider = WDMSummaryCellInfoProvider(with: sleepTimeChart)
    let sleepTimeRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sleepTimeInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let sleepTimeSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.sleepTimeStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [sleepTimeRow], footerURL: learnMoreURL)
    sectionItems.append(sleepTimeSection)
    
    // ---Sleep Quality---
    let sleepQualityInfoProvider = WDMSummaryCellInfoProvider(with: sleepQualityChart)
    let sleepQualityRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sleepQualityInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let sleepQualitySection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.sleepQualityStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [sleepQualityRow], footerURL: learnMoreURL)
    sectionItems.append(sleepQualitySection)
    
    // ---Temperature---
    let temperatureInfoProvider = WDMSummaryCellInfoProvider(with: temperatureChart)
    let temperatureRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: temperatureInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/first-aid/normal-body-temperature")
    let temperatureSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.temperatureStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [temperatureRow], footerURL: learnMoreURL)
    sectionItems.append(temperatureSection)
    
    // ---Blood Pressure---
    let bloodPressureInfoProvider = WDMSummaryCellInfoProvider(with: bloodPressureChart)
    let bloodPressureRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: bloodPressureInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/hypertension-high-blood-pressure/qa/what-is-blood-pressure")
    let bloodPressureSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.bloodPressureStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [bloodPressureRow], footerURL: learnMoreURL)
    sectionItems.append(bloodPressureSection)
    
    // ---Heart Beat---
    let heartBeatInfoProvider = WDMSummaryCellInfoProvider(with: heartBeatChart)
    let heartBeatRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: heartBeatInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/heart-disease/atrial-fibrillation/your-beating-heart")
    let heartBeatSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.heartBeatStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [heartBeatRow], footerURL: learnMoreURL)
    sectionItems.append(heartBeatSection)
    
    // ---Weight---
    let weightInfoProvider = WDMSummaryCellInfoProvider(with: weightChart)
    let weightRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: weightInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/diet/obesity/default.htm")
    let weightSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.weightStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [weightRow], footerURL: learnMoreURL)
    sectionItems.append(weightSection)
    
    // ---Blood Sugar---
    let sugarLevelInfoProvier = WDMSummaryCellInfoProvider(with: sugarLevelChart)
    let sugarlevelRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sugarLevelInfoProvier, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/diabetes/qa/what-is-my-target-blood-sugar-level")
    let sugarLevelSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.bloodSugarStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [sugarlevelRow], footerURL: learnMoreURL)
    sectionItems.append(sugarLevelSection)
    
    // ---Pain Level---
    let painLevelInfoProvider = WDMSummaryCellInfoProvider(with: painLevelChart)
    let painLevelRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: painLevelInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.healthline.com/health/pain")
    let painLevelSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.painLevelStep.rawValue.localize(), footerTitle: learnMoreText, sectionRowItems: [painLevelRow], footerURL: learnMoreURL)
    sectionItems.append(painLevelSection)
    
    return WDMSummaryInfoProvider(withSectionItems: sectionItems, presenterViewController: self)
  }
  
  @objc private func frequencySegmentTapped(_ segmentControl: WDMSimpleSegmentControl) {
    loadChartData()
  }
  
  @objc private func surveyAdded(notification: Notification) {
    if notification.name == .surveyAdded {
      ResearchKitStoreManager.shared.fetchSurvey(with: .lastNinetyDays, forceFetch: true)
      infoProvider = createInfoProvider()
    }
  }

}
