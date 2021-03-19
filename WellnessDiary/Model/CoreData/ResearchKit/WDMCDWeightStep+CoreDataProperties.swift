//
//  WDMCDWeightStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDWeightStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDWeightStep> {
        return NSFetchRequest<WDMCDWeightStep>(entityName: "WDMCDWeightStep")
    }

    @NSManaged public var value: Double
    @NSManaged public var survey: WDMCDSurvey?

}
