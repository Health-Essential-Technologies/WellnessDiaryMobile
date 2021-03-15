//
//  WDMSummaryInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 3/7/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMSummaryInfoProvider: WDMTableViewInfoProvider {

  // MARK: Methods
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let sectionItem = sectionItems[section] as? WDMSummarySectionItem else { return nil }
    return sectionItem.learnMoreLabel
  }
 
}
