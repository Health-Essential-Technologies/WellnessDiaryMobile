//
//  DefaultTableViewCell.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

class DefaultTableViewCell: SimpleTableViewCell {

    // MARK: - Properties
    
    var mainLabelText = "" {
        didSet {
            mainLabel.text = mainLabelText
        }
    }
    
    var detailLabelText = "" {
        didSet {
            detailLabel.text = detailLabelText
        }
    }
    
    private let mainLabel: SimpleLabel = {
        let lbl = SimpleLabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let detailLabel: SimpleLabel = {
        let lbl = SimpleLabel()
        lbl.textAlignment = .right
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func initialSetup() {
        
        super.initialSetup()
        
        // Add subviews
        addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
        // Constraints
        // TODO - #8 needs to going into  own class
        mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 50).isActive = true
    }

}
