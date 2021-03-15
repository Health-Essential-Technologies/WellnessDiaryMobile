//
//  WDMSummarySectionItem.swift
//  WellnessDiary
//
//  Created by luis flores on 3/13/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

public class WDMSummarySectionItem: TableViewSectionItem {

  // MARK: Properties
  
  public var learnMoreLabel: WDMHyperLinkTappableLabel
  
  // MARK: Initializers
  
  public init(headerTitle: String? = "", footerTitle: String? = "", sectionRowItems: [TableViewSectionRowItem] = [], learnMoreLabel: WDMHyperLinkTappableLabel) {
    self.learnMoreLabel = learnMoreLabel
    super.init(headerTitle: headerTitle, footerTitle: footerTitle, sectionRowItems: sectionRowItems)
  }
}
