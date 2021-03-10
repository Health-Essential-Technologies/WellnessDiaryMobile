//
//  WDMCDSleepQuantityStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDSleepQuantityStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDSleepQuantityStep> {
        return NSFetchRequest<WDMCDSleepQuantityStep>(entityName: "WDMCDSleepQuantityStep")
    }

    @NSManaged public var value: Float
    @NSManaged public var survey: WDMCDSurvey?

}
