//
//  RawComparable.swift
//  WellnessDiary
//
//  Created by luis flores on 2/1/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import UIKit

public protocol RawComparable: Comparable where Self : RawRepresentable, RawValue : Comparable {
  
}

extension RawComparable {
  
  // MARK: - Methods
  
  public static func < (lhs: Self, rhs: Self) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  
}
