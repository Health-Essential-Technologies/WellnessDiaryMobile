//
//  WDMSimpleDatePicker.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMSimpleDatePicker: UIDatePicker {
    
    // MARK: - Initializers
    
    // MARK: - Methods
    
    override func draw(_ rect: CGRect) {
        resetBackground()
    }
    
    // FIXME: - Hack until apple provides a delegate to change UI apperance.
    func resetBackground() {
        subviews.first?.subviews.first?.backgroundColor = nil
        subviews.first?.subviews.last?.backgroundColor = nil
    }
    
}
