//
//  SummaryViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/17/21.
//

import UIKit

class SummaryViewController: SimpleViewController {
  
  // MARK: - Properties
  
  lazy var containerView: SimpleViewController = {
    return SimpleViewController()
  }()
  
  lazy var detailViewController: SummaryDetailViewController = {
    return SummaryDetailViewController(storeManager: CarePlanStoreManager.sharedCarePlanStoreManager.synchronizedStoreManager)
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  override func initialSetup() {
    super.initialSetup()
    if shouldDisplayEvents() {
      add(detailViewController)
    }
    navigationItem.rightBarButtonItem = SimpleBarButtomItem(systemItem: .add)
    
  }
  
  // MARK: - Methods
  
  @discardableResult
  private func shouldDisplayEvents() -> Bool {
    return true
  }
  
}

