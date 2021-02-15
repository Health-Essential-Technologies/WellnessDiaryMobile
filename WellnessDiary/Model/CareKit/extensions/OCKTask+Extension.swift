//
//  OCKTask+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import CareKit

public let taskNotificationKey = "Notification"

extension OCKTask {
  
  // MARK: Initializers
  
  init(with task: WDMTask) {
    self.init(id: UUID().uuidString, title: task.title, carePlanID: nil, schedule: task.getSchedule())
    self.instructions = task.instructions
    self.impactsAdherence = task.impactsAdherence
    
    if task.hasNotification {
      let notificationDic = [taskNotificationKey : self.id]
      self.userInfo = notificationDic
    }
  }
}
