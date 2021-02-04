//
//  String+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/30/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation

extension String {
  
  // MARK: - Methods
  
  /// - Returns: A string with the correct localize
  public func localize() -> String {

    // In case it can be found as a whole word. Ex. "TASK_FREQUENCY"
    if let newString = localLoc(self.replacingOccurrences(of: " ", with: "_").uppercased()) {
      return newString
    }
    
    // In case a sentence can be found by individual word. Ex. "ONCE" "A" "DAY"
    var newString = ""
    let strArr = self.components(separatedBy: " ")
    strArr.forEach {
      if let strLocal = localLoc($0.uppercased()) {
        newString += strLocal + " "
      } else {
        fatalError("String not found in localize file.")
      }
    }
    
    newString.removeLast()
    return newString
  }
}
