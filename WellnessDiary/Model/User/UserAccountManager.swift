//
//  UserAccountManager.swift
//  WellnessDiary
//
//  Created by Luis Flores on 4/11/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation

final class UserAccountManager {

  // MARK: Properties
  
  public static let shared = UserAccountManager()
  
  // MARK: Initializers
  
  private init() { }
  
  // MARK: Methods
  
  public func removePasscodeFromKeychain() {
    ResearchKitStoreManager.shared.removePasscodeFromKeychain()
  }
  
}
