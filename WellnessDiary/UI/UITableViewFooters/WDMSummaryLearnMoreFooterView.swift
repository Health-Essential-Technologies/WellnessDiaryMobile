//
//  WDMSummaryLearnMoreFooterView.swift
//  WellnessDiary
//
//  Created by luis flores on 3/17/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

final class WDMSummaryLearnMoreFooterView: UITableViewHeaderFooterView {
  
  // MARK: Properties
  
  static public let reuseIdentifier = String(describing: self)
  public var learnMoreLabel: WDMHyperLinkTappableLabel?

  // MARK: Methods
  
  override func initialSetup() {
    guard let learnMoreLabel = learnMoreLabel else { return }
    
    contentView.addSubview(learnMoreLabel)
    learnMoreLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      learnMoreLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      learnMoreLabel.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor)
    ])
  }
  
  public func setLink(withText text: String, URL: URL?) {
    learnMoreLabel = WDMHyperLinkTappableLabel(text: text, url: URL, hyperLinkRange: NSRange(location: 0, length: text.count))
    initialSetup()
  }

}
