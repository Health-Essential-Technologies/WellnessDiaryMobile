//
//  WDMSingleButtonTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMSingleButtonTableViewCell: WDMSimpleTableViewCell {
    
    // MARK: - Properties
    
    var mainBtnLabelText: String = "" {
        didSet {
            mainButton.setTitle(mainBtnLabelText, for: .normal)
        }
    }
    
    let mainButton: WDMSimpleButton = {
        let btn = WDMSimpleButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    weak var tableViewDelegate: SimpleTableViewDelegate?
    
    // MARK: - Methods

    override func initialSetup() {
      super.initialSetup()
        contentView.addSubview(mainButton)
        
        mainButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mainButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
      
    }
    
    override func didSetcellInfoProvider() {
      super.didSetcellInfoProvider()
        guard let infoProvider = cellInfoProvider as? WDMSingleButtonCellInfoProvider else { return }
      mainButton.setTitle(infoProvider.mainBtnLabelText, for: .normal)
        mainButton.addTarget(WithClosure: infoProvider.btnActionTargetClosure.closure, forEvent: .touchUpInside)
    }
    
}
