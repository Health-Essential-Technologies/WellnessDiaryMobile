//
//  WDMCDSurvey+Utils.swift
//  WellnessDiary
//
//  Created by luis flores on 3/10/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import CoreData

extension WDMCDSurvey {
  
  // MARK: Properties
  
  private static var sevenDaysResultsPredicate: NSPredicate = {
    return NSPredicate(format: "%K >= %@", #keyPath(WDMCDSurvey.createdDate), Date.getAWeekAgoFromToday() as NSDate)
  }()
  
  private static var oneMonthAgoResultsPredicate: NSPredicate = {
    return NSPredicate(format: "%K >= %@", #keyPath(WDMCDSurvey.createdDate), Date.getOneMonthAgoFromToday() as NSDate)
  }()
  
  private static var threeMonthsResultsPredicate: NSPredicate = {
    return NSPredicate(format: "%K >= %@", #keyPath(WDMCDSurvey.createdDate), Date.getThreeMonthsAgoFromToday() as NSDate)
  }()
  
  // MARK: Methods
  
  public class func fetchRequest(with selectedSegment: DailySurveySummaryFrequencySegmentSelected, with sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: #keyPath(WDMCDSurvey.createdDate), ascending: false)]) -> NSFetchRequest<WDMCDSurvey> {
    
    let fetchRequest: NSFetchRequest<WDMCDSurvey> = WDMCDSurvey.fetchRequest()
    fetchRequest.sortDescriptors = sortDescriptors
    
    switch selectedSegment {
    case .lastSevenDays:
      fetchRequest.predicate = sevenDaysResultsPredicate
    case .lastThirtyDays:
      fetchRequest.predicate = oneMonthAgoResultsPredicate
    case .lastNinetyDays:
      fetchRequest.predicate = threeMonthsResultsPredicate
    }
    return fetchRequest
  }
  
}
