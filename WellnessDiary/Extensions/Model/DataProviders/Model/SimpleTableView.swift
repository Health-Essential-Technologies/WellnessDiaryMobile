//
//  SimpleTableView.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

@objc protocol SimpleTableViewDelegate: class {
    
    // MARK: - Methods
    
    func reloadAllData()
}

class SimpleTableView: UITableView {
    
}

extension SimpleTableView: SimpleTableViewDelegate {
    
    // MARK: - Methods
    
    @objc func reloadAllData() {
        reloadData()
    }
}
