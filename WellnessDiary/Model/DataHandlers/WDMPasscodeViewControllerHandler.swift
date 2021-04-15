//
//  WDMPasscodeViewControllerHandler.swift
//  WellnessDiary
//
//  Created by Luis Flores on 4/14/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import ResearchKit

final public class WDMPasscodeViewControllerHandler: NSObject {
  
  public static let kPasscodeStepIdentifier = "kPasscodeStepIdentifier"
  
  // MARK: Properties
  
  private weak var presenter: UIViewController?
  private var passcodeDelegateHandler: WDMPasscodeDelegateHandler
  
  // MARK: Initializers
  
  public init(with presenter: UIViewController) {
    self.presenter = presenter
    passcodeDelegateHandler = WDMPasscodeDelegateHandler(with: presenter)
  }
  
  // MARK: Methods
  
  public func displayPasscodeViewController() -> UIViewController {
    var passcodeViewController: UIViewController
    
    if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
      passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "TO_HELP_KEEP_YOUR_DATA_SECURE,_ENTER_YOUR_PASSCODE_BEFORE_PROCEEDING.".localize(), delegate: passcodeDelegateHandler)
    } else {
      let passcodeStep = ORKPasscodeStep(identifier: WDMPasscodeViewControllerHandler.kPasscodeStepIdentifier)
      passcodeStep.passcodeType = .type4Digit
      let passcodeTask = ORKOrderedTask(identifier: "PasscodeTask", steps: [passcodeStep])
      let passcodeTaskViewController = ORKTaskViewController(task: passcodeTask, taskRun: nil)
      passcodeTaskViewController.delegate = self
      passcodeViewController = passcodeTaskViewController
    }
    
    passcodeViewController.modalPresentationStyle = .fullScreen
    return passcodeViewController
  }
}

// MARK: ORKTaskViewControllerDelegate

extension WDMPasscodeViewControllerHandler: ORKTaskViewControllerDelegate {
  
  // MARK: Methods
  
  public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    if reason == .completed {
      presenter?.dismiss(animated: true, completion: nil)
    }
  }
}

