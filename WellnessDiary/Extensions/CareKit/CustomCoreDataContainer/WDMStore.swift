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
  
  internal lazy var customCareKitPersistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WellnessDiaryCareKit")
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Unable to load persistent storage \(error.localizedDescription)")
      }
    }
    return container
  }()
  
  internal lazy var customCareKitContext: NSManagedObjectContext = {
    return customCareKitPersistentContainer.newBackgroundContext()
  }()

  internal lazy var customResearchKitPersistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WellnessDiaryResearchKit")
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Unable to load persistent storage \(error.localizedDescription)")
      }
    }
    return container
  }()

  internal lazy var customResearchKitContext: NSManagedObjectContext = {
    return customResearchKitPersistentContainer.newBackgroundContext()
  }()
  
  // MARK: Methods
  
  public func addTaskID(_ id: String) {
    customCareKitContext.perform {
        let idObject = WDMCDTaskID(context: self.customCareKitContext)
        idObject.uniqueIdentifier = id
      self.save()
    }
  }
  
  public func fetchTask(with id: String) -> WDMCDTaskID? {
      let request: NSFetchRequest<WDMCDTaskID> = WDMCDTaskID.fetchRequest()
    request.predicate = NSPredicate(format: "%K == %@", #keyPath(WDMCDTaskID.uniqueIdentifier), id)
      request.sortDescriptors = []
      do {
        
        let idObjects = try self.customCareKitContext.fetch(request)
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
      return try customCareKitContext.fetch(request)
    }
    catch {
      fatalError("Unable to load any ids.")
    }
  }
  
  public func delete(_ task: WDMTask) {
    customCareKitContext.perform {
      guard let idObject = self.fetchTask(with: task.uniqueIdentifier) else { return }
      self.customCareKitContext.delete(idObject)
      self.save()
    }
  }
  
  public func save() {
    customCareKitContext.perform {
      if self.customCareKitContext.hasChanges {
        do {
          try self.customCareKitContext.save()
        } catch {
          fatalError("Unable to save: Error: \(error.localizedDescription)")
        }
      }
    }
  }
  
}
