//
//  UIButton+Extension.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

/**

 Source:
 https://medium.com/@jackywangdeveloper/swift-the-right-way-to-add-target-in-uibutton-in-using-closures-877557ed9455
 */

import UIKit

typealias ButtonClosure = () -> ()


typealias UIButtonTargetClosure = ((() -> Void)?) -> ()

class ButtonClosureWrapper: NSObject {
    
    // MARK: - Properties
    
    let closure: UIButtonTargetClosure
    
    // MARK: - Initializers
    
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
    
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    // MARK: - Properties
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ButtonClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ButtonClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methdods
    
    func addTarget(WithClosure closure: @escaping UIButtonTargetClosure, forEvent event: UIControl.Event) {
        targetClosure = closure
        addTarget(self, action: #selector(runClosureTargetAction), for: event)
    }
    
    @objc func runClosureTargetAction() {
        guard let targetclosure = targetClosure else { return }
        targetclosure(nil)
    }
}
