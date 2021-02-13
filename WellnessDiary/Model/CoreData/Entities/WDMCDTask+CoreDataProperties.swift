//
//  WDMCDTask+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 2/13/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDTask> {
        return NSFetchRequest<WDMCDTask>(entityName: "WDMCDTask")
    }

    @NSManaged public var id: String?
    @NSManaged public var remoteID: String?
    @NSManaged public var groupIdentifier: String?
    @NSManaged public var impactsAdherence: Bool
    @NSManaged public var instructions: String?
    @NSManaged public var title: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var notes: WDMCDNotes?

}

extension WDMCDTask : Identifiable {

}
