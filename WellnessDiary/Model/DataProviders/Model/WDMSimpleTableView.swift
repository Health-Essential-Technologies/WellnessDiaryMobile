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
    
  // MARK: - Initializers
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension WDMSimpleTableView: SimpleTableViewDelegate {
    
    // MARK: - Methods
    
    @objc func reloadAllData() {
        reloadData()
    }
}
