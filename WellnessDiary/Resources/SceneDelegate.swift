//
//  SceneDelegate.swift
//  WellnessDiary
//
//  Created by luis flores on 1/15/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let mainBarVC = WDMMainTabViewController()
    self.window = UIWindow(windowScene: windowScene)
    self.window?.rootViewController = mainBarVC
    self.window?.tintColor = Colors.mainColor.color
    self.window?.makeKeyAndVisible()
  }
}

