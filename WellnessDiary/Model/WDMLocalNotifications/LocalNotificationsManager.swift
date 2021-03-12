//
//  LocalNotificationsManager.swift
//  WellnessDiary
//
//  Created by luis flores on 2/21/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import UserNotifications

public enum LocalNotificationError: Error {
  case unableToAddNotification
  case unableToDeleteNotification
}

public class LocalNotificationsManager: NSObject, UNUserNotificationCenterDelegate {
  
  // MARK: Properties
  
  private var dateFormatter: DateFormatter = {
    var df = DateFormatter()
    df.dateStyle = .full
    return df
  }()
  static public let sharedInstance = LocalNotificationsManager()
  
  // MARK: Initializers
  
  private override init() { }
  
  // MARK: Methods
  
  public func getPermision(with completionHandler: @escaping (Bool, Error?) -> Void) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,. badge], completionHandler: completionHandler)
  }
  
  public func add(_ task: WDMTask) {
    
    let content = UNMutableNotificationContent()
    content.title = task.title ?? ""
    content.body = task.instructions ?? ""
    content.sound = UNNotificationSound.defaultCritical
    let repeatNotifications = task.taskRecurrence.frequency.count > 0 ? true : false
    
    for frequency in task.taskRecurrence.frequency {
      for occurence in task.taskRecurrence.occurence {
        
        
        let identifier = task.uniqueIdentifier + "_" + self.dateFormatter.string(from: task.startDate) + "_" + frequency.description() + "_" + TaskOccurence.getTaskAsStringFrom(occurence)
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: occurence.rawValue, weekday: frequency.rawValue), repeats: repeatNotifications)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
          if error != nil {
            print(error?.localizedDescription)
          }
        }
      }
    }

  }
  
  public func remove(_ task: WDMTask) {
    remove(with: task.uniqueIdentifier, taskRecurrence: task.taskRecurrence)
  }
  
  public func remove(with uniqueIdentifier: String, taskRecurrence: WDMTaskReccurence) {
    
    var identifiers = [String]()
    
    for frequency in taskRecurrence.frequency {
      for occurence in taskRecurrence.occurence {
        let identifier = uniqueIdentifier + "_" + frequency.description() + "_" + TaskOccurence.getTaskAsStringFrom(occurence)
        identifiers.append(identifier)
      }
    }
    
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifiers)
  }
  
  public func update(_ task: WDMTask) {
    remove(task)
    add(task)
  }
  
  public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("will present")
  }
  
  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    print("Received")
  }
  
}

