//
//  WDMCDSleepQualityStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDSleepQualityStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDSleepQualityStep> {
        return NSFetchRequest<WDMCDSleepQualityStep>(entityName: "WDMCDSleepQualityStep")
    }

    @NSManaged public var value: Int16
    @NSManaged public var survey: WDMCDSurvey?

}

extension WDMCDSleepQualityStep : Identifiable {

}
