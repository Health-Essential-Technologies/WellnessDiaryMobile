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
  
  /// - Returns: A string with the correct localize.
  public func localize() -> String {

    guard let str = localLoc(self) else {
      fatalError("String not found in localize file.")
    }
    return str
  }
  
  /// - Returns: A string with the correct amount for a given argument.
  public func localize(tableName: String = "", bundle: Bundle? = nil, value: String = "", comment: String = "", count: Int) -> String {

    guard let str = localLoc(self, tableName: tableName, bundle: bundle, value: value, comment: comment, count: count) else {
      fatalError("String not found in localize file.")
    }
    return str
  }

}
