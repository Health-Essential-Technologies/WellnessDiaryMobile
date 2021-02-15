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
  
  // MARK: Properties
  
  static let sharedCarePlanStoreManager = CarePlanStoreManager()
  
  lazy var synchronizedStoreManager: OCKSynchronizedStoreManager = {
    let store = WDMStore(name: "CKWellnessDiary")
    let ssm = OCKSynchronizedStoreManager(wrapping: store)
    return ssm
  }()
   
  // MARK: Initializers
  
  private init() {}
  
  // MARK: Methods
  
  public func add(_ task: WDMTask) {
    
    synchronizedStoreManager.store.addAnyTask(OCKTask(with: task), callbackQueue: .main) { results in
      let result = results
      switch result {
      case .success( _):
        do {
          let addedTask = try result.get()
          let store = self.synchronizedStoreManager.store as! WDMStore
          store.addTaskID(addedTask.id)
          NotificationCenter.default.post(name: .newTaskAdded, object: nil)
        } catch {
          fatalError("Unable to get saved results. This should never be called!")
        }
        break
      case .failure(let error):
        fatalError("Unable to save due to \(error.localizedDescription)")
        break
      }
    }
  }

}
