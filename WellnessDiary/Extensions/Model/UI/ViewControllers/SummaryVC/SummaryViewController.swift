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
  
  // MARK: - Methods
  
  override func initialSetup() {
    super.initialSetup()
    if shouldDisplayEvents() {
      add(detailViewController)
    }
    navigationItem.rightBarButtonItem = SimpleBarButtomItem(barButtonSystemItem: .add, target: self, action: #selector(addNavBarBtnTapped(_:)))
    
  }
  
  @objc private func addNavBarBtnTapped(_ sender: Any) {
    navigationController?.pushViewController(SummaryAddTaskViewController(), animated: true)
  }
  
  @discardableResult
  private func shouldDisplayEvents() -> Bool {
    return true
  }
  
}

