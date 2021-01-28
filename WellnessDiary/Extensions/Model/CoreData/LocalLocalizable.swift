//
//  LocalLocalizable.swift
//  WellnessDiary
//
//  Created by luis flores on 1/27/21.
//

import Foundation

/// A hook for the free function `loc` to access the framework bundle for localizations
public class LocalLocalization {

    /// An `NSLocalizedString` wrapper that searches for overrides in a main bundle before falling back to the framework provided strings
    public static func localized(
        _ key: String,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        value: String = "",
        comment: String = ""
    ) -> String {

        // Find a specified or main bundle override for the given `key`
        let str: String = {
            switch bundle {
            case .some(let bundle):
                return NSLocalizedString(
                    key,
                    tableName: tableName,
                    bundle: bundle,
                    value: value,
                    comment: comment
                )
            case .none:
                return NSLocalizedString(
                    key,
                    tableName: tableName,
                    value: value,
                    comment: comment
                )
            }
        }()

        // If the string does not equal the key, there was an override in the main bundle
        guard str == key else { return str }

        // Use this framework's localizable strings if an override is not found
        return NSLocalizedString(
            key,
            tableName: tableName,
            bundle: Bundle(for: LocalLocalization.self),
            value: value,
            comment: comment
        )

    }

}

/// This is a free function for developer convenience.
public func localLoc(_ key: String, _ comment: String = "") -> String {

    return LocalLocalization.localized(
        key,
        tableName: nil,
        bundle: nil,
        value: "",
        comment: comment
    )

}
