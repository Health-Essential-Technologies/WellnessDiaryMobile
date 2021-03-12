//
//  NotificationCenter+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation

public extension Notification.Name {
 
  // MARK: Properties
  
  static let newTaskAdded = Notification.Name(rawValue:"newTaskAdded")
  static let taskDeleted = Notification.Name(rawValue: "taskDeleted")
  static let taskUpdated = Notification.Name(rawValue: "taskUpdated")
  
  static let surveyAdded = Notification.Name("surveyAdded")
  
}
