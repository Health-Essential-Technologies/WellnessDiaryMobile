//
//  WDMTaskReccurence.swift
//  WellnessDiary
//
//  Created by luis flores on 2/22/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation

public struct WDMTaskReccurence {
  
  // MARK: Properties
  
  public var frequency: Set<TaskFrequency> = Set(TaskFrequency.allCases)
  public var occurence: Set<TaskOccurence> = Set(arrayLiteral: TaskOccurence.beforeBreakfast)
  
}
