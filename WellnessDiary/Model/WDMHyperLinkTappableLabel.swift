//
//  WDMHyperLinkTappableLabel.swift
//  WellnessDiary
//
//  Created by luis flores on 3/13/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

public class WDMHyperLinkTappableLabel: WDMSimpleLabel {
  
  // MARK: Initializers
  
  private lazy var tappingGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
  public var url: URL?
  
  public init(with frame: CGRect = .zero, text: String, url: URL?, hyperLinkRange: NSRange, fontSize: CGFloat = UIFont.systemFontSize) {
    self.url = url
    super.init(frame: frame)
    let mutableAttributedTxt = NSMutableAttributedString(string: text)
    mutableAttributedTxt.addAttribute(.link, value: url, range: hyperLinkRange)
    mutableAttributedTxt.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: hyperLinkRange)
    attributedText = mutableAttributedTxt
    isUserInteractionEnabled = true
    addGestureRecognizer(tappingGesture)

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  @objc private func handleTapOnLabel(_ gestureRecognizer: UIGestureRecognizer) {
    guard let url = url else { return }
    UIApplication.shared.openURL(url)
  }

}
