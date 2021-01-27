//
//  UIViewController+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

extension UIViewController {
    
    // MARK: - Methods
  
  /**
   Adds a child view controller with a given frame. If no frame given, child view will inherence the frame from parent view frame.
   */
  @nonobjc func add(_ child: UIViewController, frame: CGRect? = nil) {
    addChild(child)
    if let frame = frame {
      child.view.frame = frame
    } else {
      child.view.frame = view.frame
    }
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
  
  /**
   Removes the viewcontroller from its parent
   */
  func remove() {
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
    
    @objc func loadBasicTheme() {
        view.backgroundColor = .white
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc func initialSetup() {
        
    }
    
}
//
