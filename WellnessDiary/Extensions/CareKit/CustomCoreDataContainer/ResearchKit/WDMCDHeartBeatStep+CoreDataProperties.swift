//
//  WDMCDHeartBeatStep+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDHeartBeatStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDHeartBeatStep> {
        return NSFetchRequest<WDMCDHeartBeatStep>(entityName: "WDMCDHeartBeatStep")
    }

    @NSManaged public var value: Float
    @NSManaged public var survey: WDMCDSurvey?

}

extension WDMCDHeartBeatStep : Identifiable {

}
