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
      do {
        let idObject = WDMCDTaskID(context: self.customContext)
        idObject.id = id
        if self.customContext.hasChanges {
          try self.customContext.save()
        }
      } catch {
        fatalError("Unable to save id.")
      }
    }
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
  
}
