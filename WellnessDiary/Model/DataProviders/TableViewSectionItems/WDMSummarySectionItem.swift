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
  
  public var footerURL: URL?
  
  // MARK: Initializers
  
  public init(withHeaderTitle headerTitle: String? = nil, footerTitle: String? = nil, sectionRowItems: [TableViewSectionRowItem], footerURL: URL?) {
    self.footerURL = footerURL
    super.init(headerTitle: headerTitle, footerTitle: footerTitle, sectionRowItems: sectionRowItems)
  }
}
