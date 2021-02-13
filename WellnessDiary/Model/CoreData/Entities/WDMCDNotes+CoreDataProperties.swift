//
//  WDMCDNotes+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 2/13/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDNotes> {
        return NSFetchRequest<WDMCDNotes>(entityName: "WDMCDNotes")
    }

    @NSManaged public var title: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var task: WDMCDTask?

}

extension WDMCDNotes : Identifiable {

}
