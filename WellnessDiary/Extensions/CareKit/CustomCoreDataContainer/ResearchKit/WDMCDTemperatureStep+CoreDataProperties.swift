//
//  WDMCDTemperatureStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDTemperatureStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDTemperatureStep> {
        return NSFetchRequest<WDMCDTemperatureStep>(entityName: "WDMCDTemperatureStep")
    }

    @NSManaged public var value: Float
    @NSManaged public var survey: WDMCDSurvey?

}

extension WDMCDTemperatureStep : Identifiable {

}
