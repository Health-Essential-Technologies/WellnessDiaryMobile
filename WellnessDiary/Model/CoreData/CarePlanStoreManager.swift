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
  
  public func add(_ task: WDMTask, completion: (() -> Void)?) {
    
    synchronizedStoreManager.store.addAnyTask(OCKTask(with: task), callbackQueue: .main) { results in
      let result = results
      switch result {
      case .success(let addedTask):
          let store = self.synchronizedStoreManager.store as! WDMStore
          store.addTaskID(addedTask.id)
          NotificationCenter.default.post(name: .newTaskAdded, object: nil)
          if let completion = completion {
            if task.hasNotification {
              LocalNotificationsManager.sharedInstance.add(task)
            }
            completion()
          }
        break
      case .failure(let error):
        fatalError("Unable to save due to \(error.localizedDescription)")
        break
      }
    }
  }
  
  public func update(_ task: WDMTask, completion: (() ->  Void)?) {
    
    var query = OCKTaskQuery(for: task.startDate)
    query.ids = [task.uniqueIdentifier]
    synchronizedStoreManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { [unowned self] fetchedTasksResults in
      
      switch fetchedTasksResults {
      case .success(let fetchedTasks):
        
        var fetchedCastedTask = fetchedTasks.first as! OCKTask
        
        let previousSchedule = fetchedCastedTask.schedule
        let previousHasNotification = fetchedCastedTask.hasNotification
        
        fetchedCastedTask.instructions = task.instructions
        fetchedCastedTask.title = task.title
        fetchedCastedTask.schedule = task.getSchedule()
        fetchedCastedTask.userInfo?[taskNotificationKey] = task.hasNotification ? task.uniqueIdentifier : nil
        fetchedCastedTask.impactsAdherence = task.impactsAdherence
        
      // Need to remove outcome from a task before updating it.
        var outcomeQuery = OCKOutcomeQuery()
        outcomeQuery.taskIDs = [task.uniqueIdentifier]
        self.synchronizedStoreManager.store.fetchAnyOutcomes(query: outcomeQuery, callbackQueue: .main) { [unowned self] fetchOutcomesResults in
          switch fetchOutcomesResults {
          case .success(let fetchedOutcomes):
            
            // If an outcome is found for this task. Delete
            if fetchedOutcomes.count > 0 {
              self.synchronizedStoreManager.store.deleteAnyOutcomes(fetchedOutcomes, callbackQueue: .main) { [unowned self] deletedOutcomesResults in
                switch deletedOutcomesResults {
                case .success(let deletedOutcomes):
                  self.synchronizedStoreManager.store.updateAnyTask(fetchedCastedTask, callbackQueue: .main) { [unowned self] updatedTaskResults in
                    switch updatedTaskResults {
                    case .success(let updatedTasks):
                      let eventQuery = OCKEventQuery(for: updatedTasks.schedule.startDate())
                      self.synchronizedStoreManager.store.fetchAnyEvents(taskID: task.uniqueIdentifier, query: eventQuery, callbackQueue: .main) { [unowned self] fetchedEventsResults in
                        switch fetchedEventsResults {
                        case .success(let fetchedEvents):
                
                          var newOutcomes = [OCKOutcome]()
                          for event in fetchedEvents {
                            for outcome in deletedOutcomes {
                              guard let ockTask = event.task as? OCKTask, let localId = ockTask.localDatabaseID else { return }
                              let newOutcome = OCKOutcome(taskID: localId, taskOccurrenceIndex: outcome.taskOccurrenceIndex, values: outcome.values)
                              newOutcomes.append(newOutcome)
                            }
                          }

                          // Need to reversed the outcomes back
                          self.synchronizedStoreManager.store.addAnyOutcomes(newOutcomes, callbackQueue: .main) { addedOutcomesResults in
                            switch addedOutcomesResults {
                            case .success( _):
                              NotificationCenter.default.post(name: .taskUpdated, object: task)
                              if let completion = completion {
                                
                                // Need to check if previous schedule is still the same if not remove them
                                if !(previousSchedule == task.getSchedule()) {
                                  LocalNotificationsManager.sharedInstance.remove(with: task.uniqueIdentifier, taskRecurrence: task.taskRecurrence)
                                }
                              
                                if !(previousHasNotification == fetchedCastedTask.hasNotification) || !(previousSchedule == task.getSchedule()) {
                                  LocalNotificationsManager.sharedInstance.update(task)
                                }
                                
                                completion()
                              }
                            case .failure(let addedOutcomesError):
                              print("Unable to add outcomes: \(deletedOutcomes). Error: \(addedOutcomesError.localizedDescription)")
                            }
                          }
                          
                        case .failure(let fetchedEventsError):
                          print("Unable to fetch events. Error: \(fetchedEventsError.localizedDescription)")
                        }
                      }
                    case .failure(let updatedTasksError):
                      print("Unable to update task: \(fetchedCastedTask). Error: \(updatedTasksError.localizedDescription)")
                    }
                  }
                case .failure(let deletedOutcomesError):
                  print("Unable to delete outcomes. Error: \(deletedOutcomesError.localizedDescription)")
                }
              }
            } else {
              // No outcomes found
              self.synchronizedStoreManager.store.updateAnyTask(fetchedCastedTask, callbackQueue: .main) { fetchedTasksResults in
                switch fetchedTasksResults {
                case .success( _):
                  NotificationCenter.default.post(name: .taskUpdated, object: task)
                  if let completion = completion {
                    LocalNotificationsManager.sharedInstance.update(task)
                    completion()
                  }
                case .failure(let fetchedTasksError):
                  print("Unable to fetch any task. Error: \(fetchedTasksError.localizedDescription)")
                }
              }
            }
            
          case .failure(let fetchOutcomesError):
            print("Unable to fetch outcomes: Error:\(fetchOutcomesError.localizedDescription)")
          }
        }
      
      case .failure(let fetchTasksError):
        print("Unable to fetch tasks. Error: \(fetchTasksError.localizedDescription)")
      }
    }
  }

  public func delete(_ taskToDelete: WDMTask, completion: (() -> Void)?) {
    
    var query = OCKTaskQuery(for: taskToDelete.startDate)
    query.ids = [taskToDelete.uniqueIdentifier]

    synchronizedStoreManager.store.fetchAnyTasks(query: query, callbackQueue: .main) { taskResults in
      switch taskResults {
      
      case .success(let tasks):
        do {
          self.synchronizedStoreManager.store.deleteAnyTasks(tasks, callbackQueue: .main) { deletedResults in
            switch deletedResults {
            case .success( _):
              let store = self.synchronizedStoreManager.store as! WDMStore
              store.delete(taskToDelete)
              NotificationCenter.default.post(name: .taskDeleted, object: taskToDelete)
              if let completion = completion {
                LocalNotificationsManager.sharedInstance.remove(taskToDelete)
                completion()
              }
            case .failure(let error):
              fatalError("Unable to delete task: \(tasks). Error: \(error.localizedDescription)")
            }
          }
        }
      case .failure(let error):
        fatalError("Unable to fetch task. Error: \(error.localizedDescription)")
      }
    }
    
  }
}
