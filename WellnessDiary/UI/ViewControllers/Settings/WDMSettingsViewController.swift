//
//  WDMSettingsViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/17/21.
//

import UIKit
import InAppSettingsKit

class WDMSettingsViewController: IASKAppSettingsViewController, IASKSettingsDelegate {
  
    override func viewDidLoad() {
      showDoneButton = false
      showCreditsFooter = false
      title = "SETTINGS".localize()
      self.delegate = self
    
      view.tintColor = Colors.mainColor.color
        super.viewDidLoad()
    }
    
  // MARK: Methods

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    let specifier = settingsReader?.specifier(for: indexPath)!
    if specifier?.toggleStyle == IASKToggleStyle.switch {
      guard let toggle = cell.accessoryView as? IASKSwitch else { return cell }
      toggle.onTintColor = Colors.mainColor.color
    }
    return cell
  }
  
  func settingsViewController(_ settingsViewController: IASKAppSettingsViewController, buttonTappedFor specifier: IASKSpecifier) {
    if specifier.key == RESET_DAILY_SURVEY_LAST_DATE_KEY {
      UserPreference.sharedUserPreferences.setSystemPreferences(for: DAILY_SURVEY_DATE_KEY, with: Date.getYearAgoFromToday())
    }
    
    if specifier.key == LOAD_JSON_DAILY_SURVEY_SAMPLE_DATA_KEY {
      let jsonFileURL = Bundle.main.url(forResource: "DailySurveyMockData", withExtension: "json")
      let jsonData = try! Data(contentsOf: jsonFileURL!)
      let jsonDic = try! JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed) as! [String:Any]
      let surveysArrOfDic = jsonDic["surveys"] as! [[String:Any]]
      var day = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
      surveysArrOfDic.forEach {
        ResearchKitStoreManager.shared.addSurvey(fromDictionary: $0, date: day)
        day = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
      }
      ResearchKitStoreManager.shared.saveContext()
      NotificationCenter.default.post(name: .surveyAdded, object: nil)
    }
    
    if specifier.key == LOAD_RANDOM_DAILY_SURVEY_SAMPLE_DATA_KEY {
      var day = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
      for _ in 1...90 {
        var dictionary = [String:Any]()
        dictionary[WDMDailyStepType.sleepTimeStep.rawValue] = Double.random(in: 1...10)
        dictionary[WDMDailyStepType.sleepQualityStep.rawValue] = Int.random(in: 1...10)
        dictionary[WDMDailyStepType.temperatureStep.rawValue] = Double.random(in: 96...102)
        dictionary[WDMDailyStepType.bloodPressureStep.rawValue] = "\(Int.random(in: 90...150))/\(Int.random(in: 40...90))"
        dictionary[WDMDailyStepType.heartBeatStep.rawValue] = Int.random(in: 50...150)
        dictionary[WDMDailyStepType.weightStep.rawValue] = Double.random(in: 200...350)
        dictionary[WDMDailyStepType.bloodSugarStep.rawValue] = Int.random(in: 50...350)
        dictionary[WDMDailyStepType.painLevelStep.rawValue] = Int.random(in: 0...10)
        ResearchKitStoreManager.shared.addSurvey(fromDictionary: dictionary, date: day)
        day = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
      }
      ResearchKitStoreManager.shared.saveContext()
      NotificationCenter.default.post(name: .surveyAdded, object: nil)
    }
    
    if specifier.key == CLEAR_STORE_KEY {
      ResearchKitStoreManager.shared.clearDailySurveys()
    }
    
    if specifier.key == REMOVE_PASSCODE_FROM_KEYCHAIN_KEY {
      UserAccountManager.shared.removePasscodeFromKeychain()
    }
    
  }
  
  func settingsViewControllerDidEnd(_ settingsViewController: IASKAppSettingsViewController) {
  }
}
