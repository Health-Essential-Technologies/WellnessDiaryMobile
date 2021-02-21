//
//  WDMSingleButtonCellInfoProvider.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMSingleButtonCellInfoProvider: WDMCellInfoProvider {

    // MARK: - Properties
    
    let mainBtnLabelText: String
  let backgroundColor: UIColor
    let btnActionTargetClosure: ButtonClosureWrapper
    
    // MARK: - Initializers
    
  init(mainBtnLabelText: String, backgroundColor: UIColor = Colors.mainColor.color, btnActionTargetClosure: ButtonClosureWrapper) {
        self.mainBtnLabelText = mainBtnLabelText
    self.backgroundColor = backgroundColor
        self.btnActionTargetClosure = btnActionTargetClosure
    }
    
}
