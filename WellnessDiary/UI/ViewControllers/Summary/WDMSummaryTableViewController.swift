//
//  WDMSummaryTableViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 3/4/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSummaryTableViewController: WDMSimpleTableViewController {
  
  // MARK: Properties

  public var summaryView = WDMSummaryView()
  public lazy var passcodeViewControllerHandler = WDMPasscodeViewControllerHandler(with: self)

  // MARK: Lifecycle
  
  override func loadView() {
    super.loadView()
    view = summaryView
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      showPasscodeViewController()
    }
  
  // MARK: Methods
  
  private func showPasscodeViewController() {
    tabBarController?.tabBar.isHidden = true
    navigationController?.navigationBar.isHidden = true
    
    
    present(passcodeViewControllerHandler.displayPasscodeViewController(), animated: false) { [unowned self] in
      self.createInfoProvider()
      self.tabBarController?.tabBar.isHidden = false
      self.navigationController?.navigationBar.isHidden = false
    }
  }
  
  override func initialSetup() {
    
    NotificationCenter.default.addObserver(self, selector: #selector(surveyAdded(notification:)), name: .surveyAdded, object: nil)
    
    title = "SUMMARY".localize()
    summaryView.frequencySegment.addTarget(self, action: #selector(frequencySegmentTapped(_:)), for: .valueChanged)
    tableView = summaryView.tableView
    tableView.dataSource = tableViewDataSourceHandler
    tableView.delegate = tableviewDelegateHandler
  }
  
  override func createInfoProvider() {
 
    summaryView.loadChartData()
    
    var sectionItems = [TableViewSectionItem]()
    
    // ---Sleep Time Quantity---
    
      var learnMoreURL = URL(string: "https://mantasleep.com/blogs/sleep/sleep-quantity-vs-sleep-quality-which-one-makes-the-biggest-difference")
    let learnMoreStr = "LEARN_MORE".localize()
    
    let sleepTimeInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.sleepTimeChart)
    let sleepTimeRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sleepTimeInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let sleepTimeSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.sleepTimeStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [sleepTimeRow], footerURL: learnMoreURL)
    sectionItems.append(sleepTimeSection)
    
    // ---Sleep Quality---
    let sleepQualityInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.sleepQualityChart)
    let sleepQualityRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sleepQualityInfoProvider, cellType: WDMSummaryTableViewCell.self)
    let sleepQualitySection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.sleepQualityStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [sleepQualityRow], footerURL: learnMoreURL)
    sectionItems.append(sleepQualitySection)
    
    // ---Temperature---
    let temperatureInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.temperatureChart)
    let temperatureRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: temperatureInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/first-aid/normal-body-temperature")
    let temperatureSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.temperatureStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [temperatureRow], footerURL: learnMoreURL)
    sectionItems.append(temperatureSection)
    
    // ---Blood Pressure---
    let bloodPressureInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.bloodPressureChart)
    let bloodPressureRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: bloodPressureInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/hypertension-high-blood-pressure/qa/what-is-blood-pressure")
    let bloodPressureSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.bloodPressureStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [bloodPressureRow], footerURL: learnMoreURL)
    sectionItems.append(bloodPressureSection)
    
    // ---Heart Beat---
    let heartBeatInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.heartBeatChart)
    let heartBeatRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: heartBeatInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/heart-disease/atrial-fibrillation/your-beating-heart")
    let heartBeatSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.heartBeatStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [heartBeatRow], footerURL: learnMoreURL)
    sectionItems.append(heartBeatSection)
    
    // ---Weight---
    let weightInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.weightChart)
    let weightRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: weightInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/diet/obesity/default.htm")
    let weightSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.weightStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [weightRow], footerURL: learnMoreURL)
    sectionItems.append(weightSection)
    
    // ---Blood Sugar---
    let sugarLevelInfoProvier = WDMSummaryCellInfoProvider(with: summaryView.sugarLevelChart)
    let sugarlevelRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: sugarLevelInfoProvier, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.webmd.com/diabetes/qa/what-is-my-target-blood-sugar-level")
    let sugarLevelSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.bloodSugarStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [sugarlevelRow], footerURL: learnMoreURL)
    sectionItems.append(sugarLevelSection)
    
    // ---Pain Level---
    let painLevelInfoProvider = WDMSummaryCellInfoProvider(with: summaryView.painLevelChart)
    let painLevelRow = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: painLevelInfoProvider, cellType: WDMSummaryTableViewCell.self)
    learnMoreURL = URL(string: "https://www.healthline.com/health/pain")
    let painLevelSection = WDMSummarySectionItem(withHeaderTitle: WDMDailyStepType.painLevelStep.rawValue.localize(), footerTitle: summaryView.learnMoreText, sectionRowItems: [painLevelRow], footerURL: learnMoreURL)
    sectionItems.append(painLevelSection)
    
    infoProvider = WDMSummaryInfoProvider(withSectionItems: sectionItems, presenterViewController: self)
  }
  
  @objc private func frequencySegmentTapped(_ segmentControl: WDMSimpleSegmentControl) {
    summaryView.loadChartData()
  }
  
  @objc private func surveyAdded(notification: Notification) {
    if notification.name == .surveyAdded {
      ResearchKitStoreManager.shared.fetchSurvey(with: .lastNinetyDays, forceFetch: true)
      createInfoProvider()
    }
  }

}
