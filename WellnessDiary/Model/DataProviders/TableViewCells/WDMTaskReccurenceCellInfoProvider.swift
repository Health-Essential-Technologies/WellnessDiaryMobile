//
//  WDMTaskReccurenceCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 2/1/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMTaskReccurenceCellInfoProvider: WDMDefaultCellInfoProvider {

  // MARK: - Properties
  
  var taskReccurence: (frequency: TaskFrequency?, occurence: TaskOccurence?)
  
  // MARK: - Initializers
  
  init(mainLabelText: String?, frequency: TaskFrequency?, occurence: TaskOccurence?) {
    self.taskReccurence.frequency = frequency
    self.taskReccurence.occurence = occurence
    super.init(mainLabelText: mainLabelText)
  }
}
