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
  }
  
  func settingsViewControllerDidEnd(_ settingsViewController: IASKAppSettingsViewController) {
    
  }
}
