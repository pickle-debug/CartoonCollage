//
//  AppDelegate.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit
import SwiftyStoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 验证金币数据
            verifyCoinsData()

        // Override point for customization after application launch.
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
           
               for purchase in purchases {
           
                   if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
           
                      if purchase.needsFinishTransaction {
                          // Deliver content from server, then:
                          SwiftyStoreKit.finishTransaction(purchase.transaction)
                      }
                      print("purchased: \(purchase)")
                   }
               }
           }
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
    
    func verifyCoinsData() {
        let defaults = UserDefaults.standard
        let coinsKey = "userCoins" // 与CoinsModel中使用的键相同

        // 检查是否已经有保存的金币数
        if defaults.object(forKey: coinsKey) == nil {
            // 没有找到保存的金币数，设置一个初始值
            let initialCoins = 50 // 你希望的默认金币数
            defaults.set(initialCoins, forKey: coinsKey)
        }
    }

    
}

