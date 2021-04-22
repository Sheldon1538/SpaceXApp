//
//  SceneDelegate.swift
//  SpaceXApp
//
//  Created by Konstantin on 13/03/2020.
//  Copyright © 2020 Konstantin Akchurin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let apiManager = APIManager()
        let spaceXDataProvider = SpaceXDataProvider(apiManager: apiManager)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let launchesViewController = LaunchesViewController(viewModel: LaunchesViewModel(networkService: apiManager))
        let launchesNavigationController = UINavigationController(rootViewController: launchesViewController)
        launchesNavigationController.navigationBar.prefersLargeTitles = false
        launchesNavigationController.tabBarItem = UITabBarItem(title: "Launches", image: UIImage(systemName: "lineweight")?.withRenderingMode(.automatic), selectedImage: UIImage(systemName: "lineweight")?.withRenderingMode(.automatic))
        
        let rocketsNavigationController = UINavigationController(rootViewController: RocketsViewController(dataProvider: spaceXDataProvider))
        rocketsNavigationController.navigationBar.prefersLargeTitles = false
        rocketsNavigationController.tabBarItem = UITabBarItem(title: "Rockets", image: UIImage(systemName: "folder")?.withRenderingMode(.automatic), selectedImage: UIImage(systemName: "linewight")?.withRenderingMode(.automatic))
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.addChild(launchesNavigationController)
        tabBarViewController.addChild(rocketsNavigationController)
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

