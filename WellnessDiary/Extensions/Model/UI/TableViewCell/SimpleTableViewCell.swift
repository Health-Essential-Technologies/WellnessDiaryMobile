//
//  SimpleTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var cellInfoProvider: CellInfoProvider? {
        didSet {
            didSetcellInfoProvider()
        }
    }

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
        loadTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    override func initialSetup() {
        super.initialSetup()
        selectionStyle = .none
    }
    
    func didSetcellInfoProvider() {
        // Base class does nothing. Child class will override
    }
    
}
