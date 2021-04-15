//
//  UserPreference.swift
//  WellnessDiary
//
//  Created by luis flores on 2/27/21.
//  Copyright © 2021 Health Essential Technologies. All rights reserved.
//

import Foundation
import UIKit

public let ACCOUNT_UUID_KEY = "ACCOUNT_UUID_KEY"
public let DAILY_SURVEY_DATE_KEY = "DAILY_SURVEY_DATE_KEY"
public let LOAD_JSON_DAILY_SURVEY_SAMPLE_DATA_KEY = "LOAD_JSON_DAILY_SURVEY_SAMPLE_DATA_KEY"
public let LOAD_RANDOM_DAILY_SURVEY_SAMPLE_DATA_KEY = "LOAD_RANDOM_DAILY_SURVEY_SAMPLE_DATA_KEY"
public let CLEAR_STORE_KEY = "CLEAR_STORE_KEY"
public let RESET_DAILY_SURVEY_LAST_DATE_KEY = "reset_daily_survey_last_date_key"
public let REMOVE_PASSCODE_FROM_KEYCHAIN_KEY = "REMOVE_PASSCODE_FROM_KEYCHAIN_KEY"

class UserPreference  {
  
  // MARK: Methods
  
  static public var sharedUserPreferences = UserPreference()
  
  // MARK: Initializers
  
  private init() { }
  
  // MAARK: Methods
  
  public func getSettingsBundle(for key: String) -> Any {
    if let object = UserDefaults.standard.object(forKey: key) {
      return object
    }
    
    let bundleURL = Bundle.main.bundleURL
    let settingsBundlePath = bundleURL.appendingPathComponent("Settings").appendingPathExtension("bundle")
    let hiddenSettingsPlist = settingsBundlePath.appendingPathComponent("HiddenSettings").appendingPathExtension("plist")
    let dailyStepsPlist = settingsBundlePath.appendingPathComponent("DailySteps").appendingPathExtension("plist")
    
    setDefaults(for: hiddenSettingsPlist)
    setDefaults(for: dailyStepsPlist)
    UserDefaults.standard.synchronize()
    
    return UserDefaults.standard.object(forKey: key) ?? fatalError("Unable to fetch an object for this key: \(key)")
  }

  private func setDefaults(for url: URL) {
    var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
    var plistData: [String : AnyObject] = [:]
    let plistXML = FileManager.default.contents(atPath: url.path)!
    do {
      plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String : AnyObject]
      let prefSpecifier = plistData["PreferenceSpecifiers"] as! Array<[String:AnyObject]>
      setupDefaults(from: prefSpecifier)
    } catch {
      
    }
  }
  
  private func setupDefaults(from prefArray: Array<[String:AnyObject]>) {
    
    for item in prefArray {
      let key = item["Key"] as! String
      let defaultValueObject = item["DefaultValue"]
      UserDefaults.standard.setValue(defaultValueObject, forKey: key)
    }
  }
  
  public func setSystemPreferences(for key: String, with object: Any?) {
    UserDefaults.standard.setValue(object, forKey: key)
    UserDefaults.standard.synchronize()
  }
  
  public func removeSystemPrerences(for key: String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
  }
  
  public func getBool(for key: String) -> Bool {
    guard let object = getSettingsBundle(for: key) as? Bool else { return false }
    return object
  }
  
  public func getDate(for key: String) -> Date? {
    guard let object = getSettingsBundle(for: key) as? Date else { return nil }
    return object
  }
}
