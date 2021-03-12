//
//  WDMDailySurveyEditInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 2/27/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMDailySurveyEditInfoProvider: WDMTableViewInfoProvider {
  
  // MARK: Methods
  
  override func getLabelSwitchTableViewCell(forTableView tableView: UITableView, withIndexPath indexPath: IndexPath, forCellItem cellItem: TableViewSectionRowItem) -> WDMLabelSwitchTableViewCell {
    let cell = super.getLabelSwitchTableViewCell(forTableView: tableView, withIndexPath: indexPath, forCellItem: cellItem)
    cell.switchControl.addTarget(self, action: #selector(switchControlValueChanged(_:)), for: .valueChanged)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    super.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  @objc private func switchControlValueChanged(_ sender: Any) {
    guard let sender = sender as? WDMSimpleSwitch else { return }
    
    switch sender.tag {
    case CellInfoProviderTag.sleepTimeSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.sleepTimeStep.key, with: sender.isOn)
    case CellInfoProviderTag.sleepQualitySwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.sleepQualityStep.key, with: sender.isOn)
    case CellInfoProviderTag.temperatureSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.temperatureStep.key, with: sender.isOn)
    case CellInfoProviderTag.bloodPressureSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.bloodPressureStep.key, with: sender.isOn)
    case CellInfoProviderTag.heartBeatSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.heartBeatStep.key, with: sender.isOn)
    case CellInfoProviderTag.weightSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.weightStep.key, with: sender.isOn)
    case CellInfoProviderTag.bloodSugarSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.bloodSugarStep.key, with: sender.isOn)
    case CellInfoProviderTag.painlevelSwitchTag.rawValue:
      UserPreference.sharedUserPreferences.setSystemPreferences(for: WDMDailyStepType.painLevelStep.key, with: sender.isOn)
    default:
      fatalError("Unable to handle this tag")
    }
  }
}
