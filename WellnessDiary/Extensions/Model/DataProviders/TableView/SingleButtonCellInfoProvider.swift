//
//  SingleButtonCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class SingleButtonCellInfoProvider: CellInfoProvider {

    // MARK: - Properties
    
    let mainBtnLabelText: String
    let btnActionTargetClosure: ButtonClosureWrapper
    
    // MARK: - Initializers
    
    init(mainBtnLabelText: String, btnActionTargetClosure: ButtonClosureWrapper) {
        self.mainBtnLabelText = mainBtnLabelText
        self.btnActionTargetClosure = btnActionTargetClosure
    }
    
}
