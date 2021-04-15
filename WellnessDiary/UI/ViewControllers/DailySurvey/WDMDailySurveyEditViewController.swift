//
//  WDMDailySurveyEditViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 2/27/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import InAppSettingsKit

class WDMDailySurveyEditViewController: WDMSimpleTableViewController {
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: Methods
  
  override func initialSetup() {
    
    navigationItem.title = "EDIT_SURVEY".localize()
    
    tableView = WDMSimpleTableView(frame: view.bounds, style: .insetGrouped)
    tableView.isScrollEnabled = false
    
    NotificationCenter.default.addObserver(self, selector: #selector(settingsChanged(_:)), name: NSNotification.Name.IASKSettingChanged, object: nil)
    
    createInfoProvider()
    super.initialSetup()
    
  }
  
  override func createInfoProvider() {
    
    var sectionRowItems = [TableViewSectionRowItem]()

    for type in WDMDailyStepType.allCases {
      let infoProvider = WDMLabelSwitchCellInfoProvider(mainLabelText: type.rawValue.localize(), isOn: UserPreference.sharedUserPreferences.getBool(for: type.key))
      infoProvider.itemTag = type.switchTag
      let rowItem = TableViewSectionRowItem(WithtableView: tableView, cellInfoProvider: infoProvider, cellType: WDMLabelSwitchTableViewCell.self)
      sectionRowItems.append(rowItem)
    }
    
    let sectionItem = TableViewSectionItem(headerTitle: "", footerTitle: "", sectionRowItems: sectionRowItems)
    infoProvider = WDMDailySurveyEditInfoProvider(withSectionItems: [sectionItem], presenterViewController: self)
  }
  
 @objc  private func settingsChanged(_ notification: Any) {
  createInfoProvider()
  }
  
}
