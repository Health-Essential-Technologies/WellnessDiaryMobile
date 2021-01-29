//
//  WDMSimpleTableView.swift
//  WellnessDiary
//
//  Created by luis flores on 1/28/21.
//

import UIKit

@objc protocol SimpleTableViewDelegate: class {
    
    // MARK: - Methods
    
    func reloadAllData()
}

class WDMSimpleTableView: UITableView {
    
}

extension WDMSimpleTableView: SimpleTableViewDelegate {
    
    // MARK: - Methods
    
    @objc func reloadAllData() {
        reloadData()
    }
}
