//
//  WDMPasscodeDelegateHandler.swift
//  WellnessDiary
//
//  Created by Luis Flores on 4/12/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import ResearchKit

final class WDMPasscodeDelegateHandler: NSObject {
  
  // MARK: Properties
  
  public weak var presenterViewController: UIViewController?
  
  // MARK: Initializers
  
  init(with presenterViewController: UIViewController) {
    self.presenterViewController = presenterViewController
  }
  
}

// MARK: ORKPasscodeDelegate

extension WDMPasscodeDelegateHandler: ORKPasscodeDelegate {
  
  // MARK: Methods
  
  func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
    presenterViewController?.dismiss(animated: true, completion: nil)
  }
  
  func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    
  }
  
  func passcodeViewControllerForgotPasscodeTapped(_ viewController: UIViewController) {
    
  }
  
  func passcodeViewControllerText(forForgotPasscode viewController: UIViewController) -> String {
    return ""
  }
  
}
