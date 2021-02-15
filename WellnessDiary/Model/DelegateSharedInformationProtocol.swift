//
//  DelegateSharedInformationProtocol.swift
//  WellnessDiary
//
//  Created by luis flores on 2/2/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation

public protocol DelegateSharedInformationProtocol: AnyObject {
  
  // MARK: - Properties
  
  // MARK: - Functions
  
  func selected(_ date: Date)
  
}

extension DelegateSharedInformationProtocol {
  
  func selected(_ date: Date) {
    // Delegators will have to supply its own implementation
  }
  
}
