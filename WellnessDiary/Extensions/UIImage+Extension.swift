//
//  UIImage+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

extension UIImage {
    
    // MARK: - Methods
    
    public class func createImage(named name: String) -> UIImage {
        if let image = UIImage(named: name) {
            return image
        }
        
        assertionFailure("Unable to find image with name: \(name)")
        return UIImage()
    }
    
}
