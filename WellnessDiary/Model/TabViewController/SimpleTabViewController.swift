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
//        tabBar.barTintColor = ThemeKitManager.shared.getColorWith(name: ThemeKitManager.MAIN_GREEN_COLOR_VAR_NAME)
//        tabBar.tintColor = ThemeKitManager.shared.getColorWith(name: ThemeKitManager.NAVIGATION_TABBAR_TITLE_TINT_COLOR_VAR_NAME)
//        tabBar.unselectedItemTintColor = ThemeKitManager.shared.getColorWith(name: ThemeKitManager.NAVIGATION_TABBAR_UNSELECTED_ITEM_TINT_COLOR_VAR_NAME)
    }

}
