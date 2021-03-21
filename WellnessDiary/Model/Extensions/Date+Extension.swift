//
//  Date+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

extension Date {
    
    /**
     - Returns: a date object from a year ago.
     */
    static func getYearAgoFromToday() -> Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    }
  
  /**
   - Returns: a date object from three months ago.
   */
  static func getThreeMonthsAgoFromToday() -> Date {
      return Calendar.current.date(byAdding: .month, value: -3, to: Date())!
  }
  
  /**
   - Returns: a date object from one months ago.
   */
  static func getOneMonthAgoFromToday() -> Date {
      return Calendar.current.date(byAdding: .month, value: -1, to: Date())!
  }
  
  /**
   - Returns: a date object from seven days ago.
   */
  static func getAWeekAgoFromToday() -> Date {
      return Calendar.current.date(byAdding: .day, value: -7, to: Date())!
  }
  
  /**
   - Returns: Tomorrows' day
   */
  
  func tomorrow() -> Date {
    let now = Calendar.current.dateComponents(in: .current, from: self)
    let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
    return Calendar.current.date(from: tomorrow)!
  }
  
  /**
   - Returns: Yesterdays' day
   */
  
  func yesterday() -> Date {
    let now = Calendar.current.dateComponents(in: .current, from: self)
    let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! - 1)
    return Calendar.current.date(from: tomorrow)!
  }
}
