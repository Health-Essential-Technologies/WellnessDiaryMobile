//
//  MainTabViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

class MainTabViewController: SimpleTabViewController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    var tabBarViewControllers = [SimpleViewController]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Methods
    
    override func initialSetup() {
        
        super.initialSetup()
        
        tabBarViewControllers = [
//            SummaryViewController(),
//            CalendarViewController(),
////            PrescriptionViewController(),
//            MealViewController(),
//            ReminderViewController(),
//            SettingsViewController()
        ]
        
        let _ = tabBarViewControllers.map {
            setupTabBarItems(forViewController: $0)
        }
        
        viewControllers = tabBarViewControllers.map {
            MainNavigationController(rootViewController: $0)
        }
        
    }
    
    func setupTabBarItems(forViewController viewController: SimpleViewController) {
        
//        if viewController is SummaryViewController {
//            viewController.tabBarItem = SimpleTabBarItem(title: String.summaryViewControllerTitle,
//                                                         image: .summaryUnselectediconImage(),
//                                                         selectedImage: .summarySelectedIconImage())
//        } else if viewController is CalendarViewController {
//            viewController.tabBarItem = SimpleTabBarItem(title: String.calendarViewControllerTitle,
//                                                         image: .calendarUnselectedIconImage(),
//                                                         selectedImage: .calendarSelectedIconImage())
//        } else if viewController is ReminderViewController {
//            viewController.tabBarItem = SimpleTabBarItem(title: String.reminderViewControllerTitle,
//                                                         image: .reminderUnselectedIconImage(),
//                                                         selectedImage: .reminderSelectedIconImage())
//        } else if viewController is MealViewController {
//            viewController.tabBarItem = SimpleTabBarItem(title: String.mealViewControllerTitle,
//                                                         image: .mealUnselectedIconImage(),
//                                                         selectedImage: .mealSelectedIconImage())
//        } else if viewController is PrescriptionViewController {
//            viewController.tabBarItem = SimpleTabBarItem(title: String.prescriptionViewControllerTitle,
//                                                         image: .prescriptionUnselectedIconImage(),
//                                                      selectedImage: .prescriptionSelectedIconImage())
//        } else if viewController is SettingsViewController {
//            viewController.tabBarItem = SimpleTabBarItem(title: String.settingsViewControllerTitle,
//                                                         image: .settingsUnselectedIconImage(),
//                                                      selectedImage: .settingsSelectedIconImage())
//        }
    }

}
