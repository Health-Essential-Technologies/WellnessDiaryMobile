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
}
