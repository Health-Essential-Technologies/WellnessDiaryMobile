//
//  WDMSettingsViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/17/21.
//

import UIKit
import InAppSettingsKit

class WDMSettingsViewController: IASKAppSettingsViewController {
  
    override func viewDidLoad() {
      showDoneButton = false
      showCreditsFooter = false
      title = "SETTINGS".localize()
      
    
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
  
}
