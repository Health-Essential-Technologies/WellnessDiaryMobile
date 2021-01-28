//
//  SingleButtonTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class SingleButtonTableViewCell: SimpleTableViewCell {
    
    // MARK: - Properties
    
    var mainBtnLabelText: String = "" {
        didSet {
            mainButton.setTitle(mainBtnLabelText, for: .normal)
        }
    }
    
    let mainButton: SimpleButton = {
        let btn = SimpleButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        // TODO
        btn.backgroundColor = .red
        return btn
    }()
    
    weak var tableViewDelegate: SimpleTableViewDelegate?
    
    // MARK: - Methods

    override func initialSetup() {
        contentView.addSubview(mainButton)
        
        mainButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        mainButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        mainButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    override func didSetcellInfoProvider() {
        guard let infoProvider = cellInfoProvider as? SingleButtonCellInfoProvider else { return }
        mainBtnLabelText = infoProvider.mainBtnLabelText
        mainButton.addTarget(WithClosure: infoProvider.btnActionTargetClosure.closure, forEvent: .touchUpInside)
    }
    
}
