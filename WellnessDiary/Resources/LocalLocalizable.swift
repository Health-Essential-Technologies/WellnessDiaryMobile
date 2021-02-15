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

public func localLoc(_ key: String, tableName: String = "Localizable", bundle: Bundle? = nil, value: String = "", comment: String = "", count: Int) -> String? {
  
  var format = ""
  
  if let bundle = bundle {
    format = NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
  } else {
    format = NSLocalizedString(key, tableName: tableName, value: value, comment: comment)
  }
  return String.localizedStringWithFormat(format, count)
}
