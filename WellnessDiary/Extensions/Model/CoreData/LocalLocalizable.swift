//
//  LocalLocalizable.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import Foundation

/// This is a free function for developer convenience.
public func localLoc(_ key: String, _ comment: String = "") -> String? {
  let localizeStr = NSLocalizedString(key, comment: comment)
  return !(localizeStr == key) ? localizeStr : nil
}
