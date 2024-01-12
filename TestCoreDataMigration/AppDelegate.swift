//
//  AppDelegate.swift
//  TestCoreDataMigration
//
//  Created by Yriy Devyataev on 10.01.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private(set) lazy var filtersPersistentContainer = Container.init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.configureContainer()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    private func configureContainer() {
        let manager = CoreDataManager.shared
        manager.setup {
            print("loaded")
        }
    }
}

