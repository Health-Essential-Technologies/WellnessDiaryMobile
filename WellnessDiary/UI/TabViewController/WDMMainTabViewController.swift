//
//  WDMMainTabViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit
import CareKit

class WDMMainTabViewController: WDMSimpleTabViewController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    var tabBarViewControllers = [UIViewController]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    override func initialSetup() {
        
        super.initialSetup()
        
        tabBarViewControllers = [
          WDMSummaryTableViewController(),
          WDMDailyTasksViewController(),
          WDMDailySurveyMainViewController(),
          WDMSettingsViewController()
        ]
        
        let _ = tabBarViewControllers.map {
            setupTabBarItems(forViewController: $0)
        }
        
        viewControllers = tabBarViewControllers.map {
          WDMMainNavigationController(rootViewController: $0)
        }
        
    }
    
    func setupTabBarItems(forViewController viewController: UIViewController) {
        
      if viewController is WDMDailyTasksViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "DAILY_TASKS".localize(), image: Icons.unselectedDailyTaskIcon.image , selectedImage: Icons.selectedDailyTaskIcon.image)
        return
      }
      
      if viewController is WDMSettingsViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "SETTINGS".localize(), image: Icons.unselectedSettingIcon.image , selectedImage: Icons.selectedSettingIcon.image)
        return
      }
      
      if viewController is WDMDailySurveyMainViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "DAILY_SURVEY".localize(), image: Icons.unselectedSurveyIcon.image, selectedImage: Icons.selectedSurveyIcon.image)
        return
      }
      
      if viewController is WDMSummaryTableViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "SUMMARY".localize(), image: Icons.unselectedSummaryIcon.image, selectedImage: Icons.selectedSummaryIcon.image)
        return
      }
      
    }

}
