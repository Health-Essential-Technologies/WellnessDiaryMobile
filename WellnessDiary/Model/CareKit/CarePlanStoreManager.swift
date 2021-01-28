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
    let store = OCKStore(name: "HealthDairy")
//    store.populateDailyTask()
    let ssm = OCKSynchronizedStoreManager(wrapping: store)
    return ssm
  }()
  
  // MARK: - Initializers
  
  private init() {}
  
  // MARK: - Methods
}
