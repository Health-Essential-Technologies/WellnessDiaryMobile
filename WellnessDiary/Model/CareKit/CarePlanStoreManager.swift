//
//  CarePlanStoreManager.swift
//  WellnessDiary
//
//  Created by luis flores on 1/19/21.
//

import Foundation
import CareKit

enum TaskIdentifier: String, CaseIterable {
  case temperatureTest
  case bloodPressureTest
  case bloodSugarTest
}

final class CarePlanStoreManager {
  
  // MARK: - Properties
  
  static let sharedCarePlanStoreManager = CarePlanStoreManager()
  
  lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
    let store = WDMStore()
    let ssm = OCKSynchronizedStoreManager(wrapping: store)
    return ssm
  }()
   
  // MARK: - Initializers
  
  private init() {}
  
  // MARK: - Methods
  
  func add(_ task: WDMTask) {
    
    synchronizedStoreManager.store.addAnyTask(task, callbackQueue: .main) { results in
      NotificationCenter.default.post(name:NSNotification.Name(rawValue: "updated"), object: nil)
    }
  }
}
