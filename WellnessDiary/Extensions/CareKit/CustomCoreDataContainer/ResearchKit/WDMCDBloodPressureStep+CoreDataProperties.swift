//
//  WDMCDBloodPressureStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDBloodPressureStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDBloodPressureStep> {
        return NSFetchRequest<WDMCDBloodPressureStep>(entityName: "WDMCDBloodPressureStep")
    }

    @NSManaged public var systolicValue: Int16
    @NSManaged public var diastolicValue: Int16
    @NSManaged public var survey: WDMCDSurvey?

}

extension WDMCDBloodPressureStep : Identifiable {

}
