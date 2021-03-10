//
//  WDMCDTaskID+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDTaskID {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDTaskID> {
    return NSFetchRequest<WDMCDTaskID>(entityName: "WDMCDTaskID")
  }
  
}
