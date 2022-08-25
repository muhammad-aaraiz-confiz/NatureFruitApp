//
//  SceneDelegate.swift
//  Events
//
//  Created by Muhammad Aaraiz Wasim on 08/08/2022.
//

import UIKit
import Foundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var checkUser : User?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: User.self, key: key1) {
            if retrievedCodableObject.state != "" {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                var viewController = mainStoryBoard.instantiateViewController(withIdentifier: "other")
                   window?.rootViewController = viewController
                 viewController = mainStoryBoard.instantiateViewController(withIdentifier: "loginView")
            }
            else {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "loginView")
                   window?.rootViewController = viewController
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
