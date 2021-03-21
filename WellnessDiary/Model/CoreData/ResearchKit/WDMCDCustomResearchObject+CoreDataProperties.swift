//
//  WDMCDCustomResearchObject+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDCustomResearchObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDCustomResearchObject> {
        return NSFetchRequest<WDMCDCustomResearchObject>(entityName: "WDMCDCustomResearchObject")
    }

    @NSManaged public var createdDate: Date

}

extension WDMCDCustomResearchObject : Identifiable {

}
