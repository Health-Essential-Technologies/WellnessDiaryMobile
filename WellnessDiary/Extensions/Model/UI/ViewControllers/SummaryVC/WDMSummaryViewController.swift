//
//  WDMSummaryViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/17/21.
//

import UIKit

class WDMSummaryViewController: WDMSimpleViewController {
  
  // MARK: - Properties
  
  lazy var containerView: WDMSimpleViewController = {
    return WDMSimpleViewController()
  }()
  
  lazy var detailViewController: WDMSummaryDetailViewController = {
    return WDMSummaryDetailViewController(storeManager: CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager)
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    if shouldDisplayEvents() {
      add(detailViewController)
    }
    navigationItem.rightBarButtonItem = WDMSimpleBarButtomItem(barButtonSystemItem: .add, target: self, action: #selector(addNavBarBtnTapped(_:)))
    
  }
  
  @objc private func addNavBarBtnTapped(_ sender: Any) {
    navigationController?.pushViewController(WDMSummaryAddTaskViewController(), animated: true)
  }
  
  @discardableResult
  private func shouldDisplayEvents() -> Bool {
    return true
  }
  
}

