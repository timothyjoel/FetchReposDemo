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
        
        let vm = RepositoriesListViewModel()
        let vc = RepositoriesListViewController(vm: vm)
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.prefersLargeTitles = true
        nc.navigationBar.tintColor = .systemPink
        self.window = UIWindow(windowScene: windowScene)
        self.window?.backgroundColor = .systemBackground
        self.window!.rootViewController = nc
        self.window!.makeKeyAndVisible()
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

}

