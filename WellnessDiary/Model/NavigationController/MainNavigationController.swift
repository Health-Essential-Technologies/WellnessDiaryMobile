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
        let mainColor = UIColor(named: "mainColor")
        navigationBar.barTintColor = mainColor
        navigationBar.tintColor = mainColor
//        navigationBar.titleTextAttributes = StringAttributes.navigationBarTitleTitleAttributes()
    }

}
