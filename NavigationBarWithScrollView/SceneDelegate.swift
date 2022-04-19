//
//  SceneDelegate.swift
//  NavigationBarWithScrollView
//
//  Created by Seunghun Yang on 2022/04/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let appearance: UINavigationBarAppearance = {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .systemBackground
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.label.withAlphaComponent(0.0),
                .font: UIFont.systemFont(ofSize: 25, weight: .bold),
            ]
            return appearance
        }()
        
        let navigationController: UINavigationController = {
            let navigationController = UINavigationController(rootViewController: ViewController())
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            return navigationController
        }()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
