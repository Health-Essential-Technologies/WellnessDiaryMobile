//
//  TableViewSectionItem.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import Foundation

public class TableViewSectionItem {
  
  // MARK: Properties
  
  var headerTitle: String?
  var footerTitle: String?
  var sectionRowItems = [TableViewSectionRowItem]()
  
  // MARK: Initializers
  
  public init(headerTitle: String? = "", footerTitle: String? = "", sectionRowItems: [TableViewSectionRowItem] = []) {
    self.headerTitle = headerTitle
    self.footerTitle = footerTitle
    self.sectionRowItems = sectionRowItems
  }
}
