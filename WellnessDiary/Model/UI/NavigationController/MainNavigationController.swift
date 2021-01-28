//
//  MainNavigationController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

class MainNavigationController: SimpleNavigationViewController {
    
    // MARk: -
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    override func loadBasicTheme() {
      navigationBar.barTintColor = Colors.mainColor.color
      navigationBar.tintColor = Colors.mainNavigationTint.color
      navigationBar.isTranslucent = true
    }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

}