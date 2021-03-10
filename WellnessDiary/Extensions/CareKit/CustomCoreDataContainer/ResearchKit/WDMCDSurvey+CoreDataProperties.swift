//
//  WDMCDSurvey+CoreDataProperties.swift
//  WellnessDiary
//
//  Created by luis flores on 3/9/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension WDMCDSurvey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WDMCDSurvey> {
        return NSFetchRequest<WDMCDSurvey>(entityName: "WDMCDSurvey")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var weightStep: WDMCDWeightStep?
    @NSManaged public var sugarLevelStep: WDMCDSugarLevelStep?
    @NSManaged public var bloodPressureStep: WDMCDBloodPressureStep?
    @NSManaged public var heartBeatStep: WDMCDHeartBeatStep?
    @NSManaged public var temperatureStep: WDMCDTemperatureStep?
    @NSManaged public var painLevelStep: WDMCDPainLevelStep?
    @NSManaged public var sleepQualityStep: WDMCDSleepQualityStep?
    @NSManaged public var sleepQuantityStep: WDMCDSleepQuantityStep?

}

extension WDMCDSurvey : Identifiable {

}
