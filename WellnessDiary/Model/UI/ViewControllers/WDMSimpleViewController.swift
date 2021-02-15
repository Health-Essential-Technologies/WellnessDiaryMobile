//
//  WDMSimpleViewController.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit
import SwiftCharts

class WDMSimpleViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBasicTheme()
        initialSetup()
    }
    
    // MARk: - Methods
    
    override func initialSetup() {
        super.initialSetup()
      
        // Navigation items
//        let userBtn = SimpleButton(type: .custom)
//        userBtn.setImage(UIImage.userSelectedIconImage(), for: .highlighted)
//        userBtn.setImage(UIImage.userUnselectedIconImage(), for: .normal)
//        userBtn.addTarget(self, action: #selector(userIconTapped), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = SimpleBarButtonItem(customView: userBtn)
    }
    
    @objc func userIconTapped() {
        // TODO: Testing purposesg
//        let vc = ProfileViewController()
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc,
//                                      animated: true)
    }
    
    @objc func addBarBtnTapped() {
        // Base class does nothing. Sublcass will override
    }
}
