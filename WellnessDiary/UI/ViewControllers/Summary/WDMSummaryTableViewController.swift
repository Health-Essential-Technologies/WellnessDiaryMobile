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

  case lastSevenDays = 7
  case lastThirtyDays = 30
  case lastNinetyDays = 90
  
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

class WDMSummaryTableViewController: WDMSimpleTableViewController {
  
  // MARK: Properties
  
  private var frequencySegment: WDMSimpleSegmentControl = {
    let segment = WDMSimpleSegmentControl()
    segment.insertSegment(withTitle: DailySurveySummaryFrequencySegmentSelected.lastSevenDays.title .localize(), at: DailySurveySummaryFrequencySegmentSelected.lastSevenDays.segmentControlIndex(), animated: true)
    segment.insertSegment(withTitle: DailySurveySummaryFrequencySegmentSelected.lastThirtyDays.title.localize(), at: DailySurveySummaryFrequencySegmentSelected.lastThirtyDays.segmentControlIndex(), animated: true)
    segment.insertSegment(withTitle: DailySurveySummaryFrequencySegmentSelected.lastNinetyDays.title.localize(), at: DailySurveySummaryFrequencySegmentSelected.lastNinetyDays.segmentControlIndex(), animated: true)
    segment.translatesAutoresizingMaskIntoConstraints = false
    segment.backgroundColor = Colors.mainColor.color
    let color = NSAttributedString()
    segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
    segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Colors.mainColor.color], for: .selected)
    segment.selectedSegmentIndex = 0
    return segment
  }()
  
  private var lastSevenDaysAvg: CGFloat = -1.0
  private var lastNinetyDaysAvg: CGFloat = -1.0
  private var lastThirtyDaysAvg: CGFloat = -1.0
  
  // MARK: Sections
  
  private let learnMoreText = "LEARN_MORE".localize()
  private lazy var learnMoreLabel = WDMHyperLinkTappableLabel(text: learnMoreText, url: nil, hyperLinkRange: NSRange(location: 0, length: learnMoreText.count), fontSize: 11)
  
  private var sleepTimeSection: WDMSummarySectionItem {
    let headerTitle = WDMDailyStepType.sleepTimeStep.rawValue.localize()
    let infoProvider = WDMSummaryCellInfoProvider(with: sleepTimeChart)
    let sectionRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: infoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreLabel.url = URL(string: "https://mantasleep.com/blogs/sleep/sleep-quantity-vs-sleep-quality-which-one-makes-the-biggest-difference")
    return WDMSummarySectionItem(headerTitle: headerTitle, footerTitle: "", sectionRowItems: [sectionRow], learnMoreLabel: learnMoreLabel)
  }
  
  
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
  
  private func loadChartData() {
    
    let selectedSegment = DailySurveySummaryFrequencySegmentSelected.getDailySurveySummaryFrequencySegmentSelected(from: frequencySegment.selectedSegmentIndex)
    guard let surveys = ResearchKitStoreManager.shared.fetchSurvey(with: selectedSegment) else { return }
    
    let charts =    [sleepTimeChart, sleepQualityChart, temperatureChart, bloodPressureChart, heartBeatChart, weightChart, sugarLevelChart, painLevelChart]
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
            $0.headerView.detailLabel.text = "YOUR_SYSTOLIC_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)"
            $0.headerView.detailLabel.text?.append("\n" + "YOUR_DIASTOLIC_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)")
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
        if $0 == bloodPressureChart {
          $0.graphView.yMinimum = 20
        } else {
          $0.graphView.yMinimum = $0.graphView.dataSeries.first?.dataPoints.min { a, b in a.y < b.y }?.y
        }
      }
  }
  
  override func createInfoProvider() -> WDMTableViewInfoProvider {

    loadChartData()
    
    var sectionItems = [TableViewSectionItem]()
    
    // ---Sleep Time Quantity---
    let sleepTimeInfoProvider = WDMSummaryCellInfoProvider(with: sleepTimeChart)
    let sleepTimeRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sleepTimeInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let sleepTimeSection = TableViewSectionItem(headerTitle: WDMDailyStepType.sleepTimeStep.rawValue.localize(), sectionRowItems: [sleepTimeRow])
    sectionItems.append(sleepTimeSection)
    
    // ---Sleep Quality---
    let sleepQualityInfoProvider = WDMSummaryCellInfoProvider(with: sleepQualityChart)
    let sleepQualityRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sleepQualityInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let sleepQualitySection = TableViewSectionItem(headerTitle: WDMDailyStepType.sleepQualityStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [sleepQualityRow])
    sectionItems.append(sleepQualitySection)
    
    // ---Temperature---
    let temperatureInfoProvider = WDMSummaryCellInfoProvider(with: temperatureChart)
    let temperatureRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: temperatureInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let temperatureSection = TableViewSectionItem(headerTitle: WDMDailyStepType.temperatureStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [temperatureRow])
    sectionItems.append(temperatureSection)
    
    // ---Blood Pressure---
    let bloodPressureInfoProvider = WDMSummaryCellInfoProvider(with: bloodPressureChart)
    let bloodPressureRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: bloodPressureInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let bloodPressureSection = TableViewSectionItem(headerTitle: WDMDailyStepType.bloodPressureStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [bloodPressureRow])
    sectionItems.append(bloodPressureSection)
    
    // ---Heart Beat---
    let heartBeatInfoProvider = WDMSummaryCellInfoProvider(with: heartBeatChart)
    let heartBeatRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: heartBeatInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let heartBeatSection = TableViewSectionItem(headerTitle: WDMDailyStepType.heartBeatStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [heartBeatRow])
    sectionItems.append(heartBeatSection)
    
    // ---Weight---
    let weightInfoProvider = WDMSummaryCellInfoProvider(with: weightChart)
    let weightRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: weightInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let weightSection = TableViewSectionItem(headerTitle: WDMDailyStepType.weightStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [weightRow])
    sectionItems.append(weightSection)
    
    // ---Blood Sugar---
    let sugarLevelInfoProvier = WDMSummaryCellInfoProvider(with: sugarLevelChart)
    let sugarlevelRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sugarLevelInfoProvier, cellType: WDMSummaryTableViewCell.self)
    let sugarLevelSection = TableViewSectionItem(headerTitle: WDMDailyStepType.bloodSugarStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [sugarlevelRow])
    sectionItems.append(sugarLevelSection)
    
    // ---Pain Level---
    let painLevelInfoProvider = WDMSummaryCellInfoProvider(with: painLevelChart)
    let painLevelRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: painLevelInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let painLevelSection = TableViewSectionItem(headerTitle: WDMDailyStepType.painLevelStep.rawValue.localize(), footerTitle: nil, sectionRowItems: [painLevelRow])
    sectionItems.append(painLevelSection)
    
    return WDMSummaryInfoProvider(withSectionItems: sectionItems, presenterViewController: self)
  }
  
  @objc private func frequencySegmentTapped(_ segmentControl: WDMSimpleSegmentControl) {
    infoProvider = createInfoProvider()
  }
  
  @objc private func surveyAdded(notification: Notification) {
    if notification.name == .surveyAdded {
      ResearchKitStoreManager.shared.fetchSurvey(with: .lastNinetyDays, forceFetch: true)
      infoProvider = createInfoProvider()
    }
  }

}
