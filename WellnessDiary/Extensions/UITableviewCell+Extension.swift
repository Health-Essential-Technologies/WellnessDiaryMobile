//
//  UITableviewCell+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

extension UITableViewCell {
    
    // MARK: - Properties
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
