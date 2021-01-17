//
//  SimpleTabViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

class SimpleTabViewController: UITabBarController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBasicTheme()
        initialSetup()
    }
    
    // MARk: - Methods
    
    override func loadBasicTheme() {
        let mainColor = UIColor(named: "mainColor")
        tabBar.barTintColor = mainColor
      tabBar.tintColor = UIColor.white
      tabBar.unselectedItemTintColor = UIColor.white
    }

}
