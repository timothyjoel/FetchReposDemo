//
//  SceneDelegate.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = getNavigationController()
        let coordinatoor = RepositoriesListCoordinator()
        let window = getWindow(windowScene: windowScene, navigationController: navigationController)
        self.window = window
        
        coordinatoor.navigationController = navigationController
        coordinatoor.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        NetMonitor.shared.startMonitoring()
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NetMonitor.shared.stopMonitoring()
    }
    
    // MARK: - Helpers
    
    func getNavigationController() -> UINavigationController {
        let nc = UINavigationController()
        nc.navigationBar.prefersLargeTitles = true
        nc.navigationBar.tintColor = .mainColor
        return nc
    }
    
    func getWindow(windowScene: UIWindowScene, navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .systemBackground
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
        return window
    }

}

