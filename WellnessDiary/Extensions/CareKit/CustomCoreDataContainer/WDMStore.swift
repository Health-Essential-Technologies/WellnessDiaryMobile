//
//  WDMStore.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit
import CareKit
import CoreData

class WDMStore: OCKStore {
  
  // MARK: Properties
  
  internal lazy var customPersistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WellnessDiary")
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Unable to load persistent storage \(error.localizedDescription)")
      }
    }
    return container
  }()
  
  internal lazy var customContext: NSManagedObjectContext = {
    return customPersistentContainer.newBackgroundContext()
  }()
  
  // MARK: Methods
  
  public func addTaskID(_ id: String) {
    customContext.perform {
        let idObject = WDMCDTaskID(context: self.customContext)
        idObject.uniqueIdentifier = id
      self.save()
    }
  }
  
  public func fetchTask(with id: String) -> WDMCDTaskID? {
      let request: NSFetchRequest<WDMCDTaskID> = WDMCDTaskID.fetchRequest()
    request.predicate = NSPredicate(format: "%K == %@", #keyPath(WDMCDTaskID.uniqueIdentifier), id)
      request.sortDescriptors = []
      do {
        
        let idObjects = try self.customContext.fetch(request)
        return idObjects.first
      } catch {
        print("Unable to fetch task with id: \(id). Error: \(error.localizedDescription)")
      }
    return nil
  }
  
  public func fetchAllTaskIDs() -> [WDMCDTaskID] {
    let request: NSFetchRequest<WDMCDTaskID> = WDMCDTaskID.fetchRequest()
    request.sortDescriptors = []
    do {
      return try customContext.fetch(request)
    }
    catch {
      fatalError("Unable to load any ids.")
    }
  }
  
  public func delete(_ task: WDMTask) {
    customContext.perform {
      guard let idObject = self.fetchTask(with: task.uniqueIdentifier) else { return }
      self.customContext.delete(idObject)
      self.save()
    }
  }
  
  public func save() {
    customContext.perform {
      if self.customContext.hasChanges {
        do {
          try self.customContext.save()
        } catch {
          fatalError("Unable to save: Error: \(error.localizedDescription)")
        }
      }
    }
  }
  
}
