//
//  WDMMainTabViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

class WDMMainTabViewController: WDMSimpleTabViewController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    var tabBarViewControllers = [UIViewController]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Methods
    
    override func initialSetup() {
        
        super.initialSetup()
        
        tabBarViewControllers = [
          WDMSummaryViewController(),
          WDMMedicationViewController(),
          WDMSettingsViewController(),
        ]
        
        let _ = tabBarViewControllers.map {
            setupTabBarItems(forViewController: $0)
        }
        
        viewControllers = tabBarViewControllers.map {
          WDMMainNavigationController(rootViewController: $0)
        }
        
    }
    
    func setupTabBarItems(forViewController viewController: UIViewController) {
        
      if viewController is WDMSummaryViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "Summary", image: Icons.unselectedSummaryIcon.image , selectedImage: Icons.selectedSummaryIcon.image)
      }
      
      if viewController is WDMSettingsViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "Settings", image: Icons.unselectedSettingIcon.image , selectedImage: Icons.selectedSettingIcon.image)
      }
      
      if viewController is WDMMedicationViewController {
        viewController.tabBarItem = WDMSimpleTabBarItem(title: "Medication", image: Icons.unselectedMedicationIcon.image, selectedImage: Icons.selectedMedicationIcon.image)
      }
      
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
