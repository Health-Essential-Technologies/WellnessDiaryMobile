//
//  WDMStore.swift
//  WellnessDiary
//
//  Created by luis flores on 2/13/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import CoreData
import CareKit

public class WDMStore: OCKStoreProtocol, Equatable {
  
  // MARK: Properties
  internal lazy var persistentContainer: NSPersistentCloudKitContainer = {
      let container = NSPersistentCloudKitContainer(name: "WellnessDiary")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()
  
  internal lazy var context: NSManagedObjectContext = {
    return persistentContainer.newBackgroundContext()
  }()

  // MARK: Methods

  func saveContext () throws {
    context.perform {
      
    }
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
  public func fetchCarePlans(query: OCKCarePlanQuery, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<[OCKCarePlan]>) {
    //
  }
  
  public func fetchContacts(query: OCKContactQuery, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<[OCKContact]>) {
    //
  }
  
  public func fetchPatients(query: OCKPatientQuery, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<[OCKPatient]>) {
    //
  }
  
  public func fetchTasks(query: OCKTaskQuery, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<[WDMTask]>) {
    //
  }
  
  public func fetchOutcomes(query: OCKOutcomeQuery, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<[OCKOutcome]>) {
    //
  }
  
  
  // MARK: Methods
  public func addCarePlans(_ plans: [Plan], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Plan]>?) {
    //
  }
  
  public func updateCarePlans(_ plans: [Plan], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Plan]>?) {
    //
  }
  
  public func deleteCarePlans(_ plans: [Plan], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Plan]>?) {
    //
  }
  
  public func addContacts(_ contacts: [Contact], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Contact]>?) {
    //
  }
  
  public func updateContacts(_ contacts: [Contact], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Contact]>?) {
    //
  }
  
  public func deleteContacts(_ contacts: [Contact], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Contact]>?) {
    //
  }
  
  public func addPatients(_ patients: [Patient], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Patient]>?) {
    //
  }
  
  public func updatePatients(_ patients: [Patient], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Patient]>?) {
    //
  }
  
  public func deletePatients(_ patients: [Patient], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Patient]>?) {
    //
  }
  
  public static func == (lhs: WDMStore, rhs: WDMStore) -> Bool {
    return true
  }
  
  public typealias Plan = OCKCarePlan
  
  public typealias PlanQuery = OCKCarePlanQuery
  
  public typealias Contact = OCKContact
  
  public typealias ContactQuery = OCKContactQuery
  
  public func fetchEvents(taskID: String, query: OCKEventQuery, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<[Event]>) {
    //
  }
  
  public func fetchEvent(forTask task: Task, occurrence: Int, callbackQueue: DispatchQueue, completion: @escaping OCKResultClosure<Event>) {
    //
  }
  

  
  public func addUpdateOrDeleteTasks(addOrUpdate tasks: [Task], delete deleteTasks: [Task], callbackQueue: DispatchQueue, completion: ((Result<([Task], [Task], [Task]), OCKStoreError>) -> Void)?) {
    //
  }
  
  public func addOutcomes(_ outcomes: [Outcome], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Outcome]>?) {
    //
  }
  
  public func updateOutcomes(_ outcomes: [Outcome], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Outcome]>?) {
    //
  }
  
  public func deleteOutcomes(_ outcomes: [Outcome], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Outcome]>?) {
    //
  }
  
  public func addTasks(_ tasks: [Task], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Task]>?) {
    context.perform {
      do {
        // Needs to create the objects here
        try self.saveContext()
        // Needs to send back the created tasks
        
        callbackQueue.async {
//          self.taskDelegate?.taskStore(self, didAddTasks: addedTasks)
//          completion?(.success(addedTasks))
        }
      } catch {
        self.context.rollback()
        callbackQueue.async {
          completion?(.failure(.addFailed(reason: "Failed to add WDMTask: [\(tasks)]. \(error.localizedDescription)")))
        }
      }
    }
  }
  
  public func updateTasks(_ tasks: [Task], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Task]>?) {
    //
  }
  
  public func deleteTasks(_ tasks: [Task], callbackQueue: DispatchQueue, completion: OCKResultClosure<[Task]>?) {
    //
  }
  
  public typealias Patient = OCKPatient
  
  public typealias PatientQuery = OCKPatientQuery
  
  public var carePlanDelegate: OCKCarePlanStoreDelegate?
  
  public var contactDelegate: OCKContactStoreDelegate?
  
 
  
  public typealias TaskQuery = OCKTaskQuery
  
  public typealias Outcome = OCKOutcome
  
  public typealias OutcomeQuery = OCKOutcomeQuery
  
  public var patientDelegate: OCKPatientStoreDelegate?
  
  public var taskDelegate: OCKTaskStoreDelegate?
  
  public var outcomeDelegate: OCKOutcomeStoreDelegate?
  
  
  
}

