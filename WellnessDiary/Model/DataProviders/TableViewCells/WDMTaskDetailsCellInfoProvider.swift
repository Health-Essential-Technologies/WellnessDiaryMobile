//
//  WDMTaskDetailsCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 2/15/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

class WDMTaskDetailsCellInfoProvider: WDMCellInfoProvider {

  // MARK: Properties
  
  let task: WDMTask
  
  // MARK: Initializers
  
  init(with task: WDMTask) {
    self.task = task
  }
  
}
