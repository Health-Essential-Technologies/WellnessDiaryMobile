//
//  WDMHealthEntryTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class WDMHealthEntryTableViewCell: WDMSimpleTableViewCell {

    // MARK: - Properties
    
    let mainLabel: WDMSimpleLabel = {
       let lbl = WDMSimpleLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: - Properties
    
    override func initialSetup() {
        contentView.addSubview(mainLabel)
        
        // TODO: Needs to add more constraints as more UIItems are added.
        mainLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
    }
    
    override func didSetcellInfoProvider() {
    }

}