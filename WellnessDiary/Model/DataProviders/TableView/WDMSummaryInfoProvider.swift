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
  
  override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return nil
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let sectionItem = sectionItems[section] as? WDMSummarySectionItem ,
          let learnMoreFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: WDMSummaryLearnMoreFooterView.reuseIdentifier) as? WDMSummaryLearnMoreFooterView,
          let footerTitle = sectionItem.footerTitle else { return nil }
    learnMoreFooter.setLink(withText: footerTitle, URL: sectionItem.footerURL)
    return learnMoreFooter
  }
 
}
