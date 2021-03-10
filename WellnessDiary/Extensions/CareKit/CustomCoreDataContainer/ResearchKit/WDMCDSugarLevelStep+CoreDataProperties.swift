//
//  WDMCDSugarLevelStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDSugarLevelStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDSugarLevelStep> {
        return NSFetchRequest<WDMCDSugarLevelStep>(entityName: "WDMCDSugarLevelStep")
    }

    @NSManaged public var attribute: Float
    @NSManaged public var survey: WDMCDSurvey?

}

extension WDMCDSugarLevelStep : Identifiable {

}
