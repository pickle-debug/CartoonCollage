//
//  AppDelegate.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let main = MainViewController()
        main.tabBarItem.image = UIImage(named: "Main")?.withRenderingMode(.alwaysOriginal)
        main.tabBarItem.selectedImage = UIImage(named: "Main_heightlight")?.withRenderingMode(.alwaysOriginal)

        
        let record = RecordViewController()
        record.tabBarItem.image = UIImage(named: "Record")?.withRenderingMode(.alwaysOriginal)
        record.tabBarItem.selectedImage = UIImage(named: "Record_heightlight")?.withRenderingMode(.alwaysOriginal)
        
        
        let store = StoreViewController()
        store.tabBarItem.image = UIImage(named: "Store")?.withRenderingMode(.alwaysOriginal)
        store.tabBarItem.selectedImage = UIImage(named: "Store_heightlight")?.withRenderingMode(.alwaysOriginal)
        
        let tabBarController = UITabBarController()
        // tabBarController的主题颜色
//        tabBarController.tabBar.tintColor = UIColor.init(colorLiteralRed: 9/255.0, green: 187/255.0, blue: 7/255.0, alpha: 1)
        // tabBarController的子视图控制器集合
        tabBarController.viewControllers = [main,record,store]
        // 修改tabbar的位置
        tabBarController.tabBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        // 添加到rootViewController
        window?.rootViewController = tabBarController
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

