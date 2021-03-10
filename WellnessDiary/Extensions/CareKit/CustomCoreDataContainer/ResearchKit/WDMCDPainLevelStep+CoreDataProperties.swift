//
//  WDMCDPainLevelStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDPainLevelStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDPainLevelStep> {
        return NSFetchRequest<WDMCDPainLevelStep>(entityName: "WDMCDPainLevelStep")
    }

    @NSManaged public var value: Int16
    @NSManaged public var survey: WDMCDSurvey?

}
