//
//  WDMSummaryView.swift
//  WellnessDiary
//
//  Created by Luis Flores on 4/12/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit

class WDMSummaryView: WDMSimpleView {
  
  // MARK: Properties
  
  public var frequencySegment = WDMFrequencySegmentControl()
  
  public var tableView: WDMSimpleTableView!
  
  public let learnMoreText = "LEARN_MORE".localize()
  
  public let sleepTimeChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  public let sleepQualityChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  public let temperatureChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  public let bloodPressureChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .bar)
    return chart
  }()
  
  public let heartBeatChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  public let weightChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  public let sugarLevelChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  public let painLevelChart: OCKCartesianChartView = {
    let chart = OCKCartesianChartView(type: .line)
    return chart
  }()
  
  // MARK: Initializers
  
  init() {
    super.init(frame: .zero)
    initialSetup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  override func initialSetup() {
    tableView = WDMSimpleTableView(frame: bounds, style: .insetGrouped)
    tableView.register(WDMSummaryLearnMoreFooterView.self, forHeaderFooterViewReuseIdentifier: WDMSummaryLearnMoreFooterView.reuseIdentifier)
    
    
    addSubview(tableView)
    addSubview(frequencySegment)
    
    NSLayoutConstraint.activate([
      
      frequencySegment.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
      frequencySegment.leadingAnchor.constraint(equalTo:  layoutMarginsGuide.leadingAnchor),
      frequencySegment.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.topAnchor.constraint(equalTo: frequencySegment.bottomAnchor, constant: 8),
      tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
    ])
    
  }
  
  public func clearData(withChart chart: OCKCartesianChartView) {
    DispatchQueue.main.async {
      chart.graphView.dataSeries.removeAll()
      chart.headerView.detailLabel.text = ""
    }
  }
  
  public func loadChartData() {
    
    let selectedSegment = DailySurveySummaryFrequencySegmentSelected.getDailySurveySummaryFrequencySegmentSelected(from: self.frequencySegment.selectedSegmentIndex)
    
    let charts =    [self.sleepTimeChart, self.sleepQualityChart, self.temperatureChart, self.bloodPressureChart, self.heartBeatChart, self.weightChart, self.sugarLevelChart, self.painLevelChart]
    
    charts.forEach {
      self.clearData(withChart: $0)
    }
    
    DispatchQueue.global().async {
      guard let surveys = ResearchKitStoreManager.shared.fetchSurvey(with: selectedSegment) else { return }
      
      DispatchQueue.main.async {
        charts.forEach { chart in
          chart.graphView.xMinimum = 1
          chart.graphView.xMaximum = CGFloat(selectedSegment.rawValue)
          chart.setXAxisLabels(from: selectedSegment)
        }
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
        }
        
        if let sleepQuality = $1.sleepQualityStep {
          let point = CGPoint(x: CGFloat(day), y: CGFloat(sleepQuality.value))
          sleepQualityDataSeries.dataPoints.append(point)
        }
        
        if let temperature = $1.temperatureStep {
          let point = CGPoint(x: CGFloat(day), y: CGFloat(temperature.value))
          temperatureDataSeries.dataPoints.append(point)
        }
        
        // Need to do systolic
        if let bloodPressure = $1.bloodPressureStep {
          let systolicPoint = CGPoint(x: CGFloat(day), y: CGFloat(bloodPressure.systolicValue))
          bloodPressureSystolicDataSeries.dataPoints.append(systolicPoint)
          
          let diastolicPoint = CGPoint(x: CGFloat(day), y: CGFloat(bloodPressure.diastolicValue))
          bloodPressureDiastolicDataSeries.dataPoints.append(diastolicPoint)
        }
        
        if let heartBeat = $1.heartBeatStep {
          let point = CGPoint(x: CGFloat(day), y: CGFloat(heartBeat.value))
          heartBeatDataSeries.dataPoints.append(point)
        }
        
        if let weight = $1.weightStep {
          let point = CGPoint(x: CGFloat(day), y: CGFloat(weight.value))
          weightDataSeries.dataPoints.append(point)
        }
        
        if let sugarLevel = $1.sugarLevelStep {
          let point = CGPoint(x: CGFloat(day), y: CGFloat(sugarLevel.value))
          sugarLevelDataSeries.dataPoints.append(point)
        }
        
        if let painLevel = $1.painLevelStep {
          let point = CGPoint(x: CGFloat(day), y: CGFloat(painLevel.value))
          painLevelDataSeries.dataPoints.append(point)
          
        }
        
      }
      
      DispatchQueue.main.async {
        
        // Averages calculations
          charts.forEach {
            if let dataSeries = $0.graphView.dataSeries.first {
              let dataSeriesCount = dataSeries.dataPoints.count
              if dataSeriesCount > 1 {
                let dataSeriesSum = dataSeries.dataPoints.compactMap{$0}.reduce(into: CGPoint()) { result, point in result.y += point.y }.y
                let dataSeriesAverage = Int(round(Double(dataSeriesSum) / Double(dataSeriesCount)))
                
                switch $0 {
                
                case self.sleepTimeChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_SLEEP_TIME_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                case self.sleepQualityChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_SLEEP_QUALITY_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                case self.temperatureChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_BODY_TEMPERATURE_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                case self.bloodPressureChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_SYSTOLIC_AVERAGE_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)" + "\n" + "YOUR_DIASTOLIC_AVERAGE_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  
                  break
                case self.heartBeatChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_HEART_BEAT_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                case self.weightChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_WEIGHT_HAS_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                case self.sugarLevelChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_BLOOD_SUGAR_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                case self.painLevelChart:
                  self.setHeaderDetailLabel(for: $0, detailTitle: "YOUR_AVERAGE_PAIN_LEVELS_HAVE_BEEN:".localize() + " " + "\(dataSeriesAverage)")
                  break
                default:
                  break
              }
            }
          }
        }
        
        self.sleepTimeChart.graphView.dataSeries = [sleepQuantityDataSeries]
        self.sleepQualityChart.graphView.dataSeries = [sleepQualityDataSeries]
        self.temperatureChart.graphView.dataSeries = [temperatureDataSeries]
        self.bloodPressureChart.graphView.dataSeries = [bloodPressureSystolicDataSeries,bloodPressureDiastolicDataSeries]
        self.heartBeatChart.graphView.dataSeries = [heartBeatDataSeries]
        self.weightChart.graphView.dataSeries = [weightDataSeries]
        self.sugarLevelChart.graphView.dataSeries = [sugarLevelDataSeries]
        self.painLevelChart.graphView.dataSeries = [painLevelDataSeries]
        
        // Set the minimums for each graph
        
        charts.forEach {
          $0.graphView.yMinimum = $0.graphView.dataSeries.first?.dataPoints.min { a, b in a.y < b.y }?.y
          
          let yMinimum = $0.graphView.yMinimum ?? 0
          let yMaximum = $0.graphView.dataSeries.first?.dataPoints.min { a, b in a.y > b.y }?.y ?? 0
          
          if $0 == self.sugarLevelChart || $0 == self.weightChart || $0 == self.heartBeatChart {
            $0.graphView.yMinimum = yMinimum - 5
            $0.graphView.yMaximum = yMaximum + 5
          } else if $0 == self.bloodPressureChart {
            $0.graphView.yMinimum = 0
          }else if $0 == self.painLevelChart || $0 == self.temperatureChart || $0 == self.sleepQualityChart {
            $0.graphView.yMinimum = yMinimum - 1
            $0.graphView.yMaximum = yMaximum + 1
          }
        }
      }
    }
  }
  
  private func setHeaderDetailLabel(for chart: OCKCartesianChartView, detailTitle: String) {
    DispatchQueue.main.async {
      chart.headerView.detailLabel.text = detailTitle
    }
  }
  
}
