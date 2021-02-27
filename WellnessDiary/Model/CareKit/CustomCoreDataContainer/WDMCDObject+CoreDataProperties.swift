//
//  WDMCDObject+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDObject {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDObject> {
    return NSFetchRequest<WDMCDObject>(entityName: "WDMCDObject")
  }
  
  @NSManaged public var createdDate: Date?
  @NSManaged public var uniqueIdentifier: String
  
}

extension WDMCDObject : Identifiable {
  
}
