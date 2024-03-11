//
//  CCUtils.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/11.
//

import Foundation
import SwiftyStoreKit
import StoreKit
class CCUtils {
    
    // MARK: - Coins
    static func saveCoinsValue(_ coins: Int) {
        UserDefaults.standard.set(coins, forKey: "coinsValue")
    }

    static func loadCoinsValue() -> Int {
        return UserDefaults.standard.integer(forKey: "coinsValue")
    }
//    // MARK: - Purchase 内购相关
//    //MARK: Get Info For Purchase Product
//    func getInfo(purchase : RegisteredPurchase) {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//      
//        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue], completion: {
//            result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            self.showAlert(alert: self.alertForProductRetrievalInfo(result: result))
//            
//            
//        })
//    }
//    
//    //MARK: Make Purchase
//    func purchase(purchase : RegisteredPurchase) {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue, quantity: 1, atomically: true) { result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            switch result {
//            case .success(let purchase):
//                print("Purchase Success: \(purchase.productId)")
//                if purchase.needsFinishTransaction {
//                    SwiftyStoreKit.finishTransaction(purchase.transaction)
//                }
//                self.showAlert(alert: self.alertForPurchaseResult(result: result))
//            case .error(let error):
//                switch error.code {
//                case .unknown: print("Unknown error. Please contact support")
//                case .clientInvalid: print("Not allowed to make the payment")
//                case .paymentCancelled: break
//                case .paymentInvalid: print("The purchase identifier was invalid")
//                case .paymentNotAllowed: print("The device is not allowed to make the payment")
//                case .storeProductNotAvailable: print("The product is not available in the current storefront")
//                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
//                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
//                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
//                default: print((error as NSError).localizedDescription)
//                }
//            }
//        }
//
//    }
//    
//    //MARK: Restore Purchases
//    func restorePurchases() {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        
//        
//        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
//            result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            for product in result.restoredPurchases {
//                if product.needsFinishTransaction {
//                    SwiftyStoreKit.finishTransaction(product.transaction)
//                }
//            }
//            self.showAlert(alert: self.alertForRestorePurchases(result: result))
//        })
//        
//    }
//    
//    //MARK: Refresh/update Receipt
//    func fetchUpdatedReceipt(){
//        SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
//            switch result {
//            case .success(let receiptData):
//                let encryptedReceipt = receiptData.base64EncodedString(options: [])
//                print("Fetch receipt success:\n\(encryptedReceipt)")
//            case .error(let error):
//                print("Fetch receipt failed: \(error)")
//            }
//        }
//    }
//    
//    //MARK: Verify Receipt
//    func verifyReceipt() {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        
//        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: sharedSecret)
//        SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            self.showAlert(alert: self.alertForVerifyReceipt(result: result))
//            switch result {
//            case .success(let receipt):
//                print("Verify receipt success: \(receipt)")
//            case .error(let error):
//                print("Verify receipt failed: \(error)")
//                self.fetchUpdatedReceipt()
//            }
//        }
//    }
//    
//    
//    //MARK: Verify Subscription/Purchase
//    func verifyPurcahse(product : RegisteredPurchase) {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        
//        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: sharedSecret)
//        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            switch result {
//            case .success(let receipt):
//                let productId = self.bundleID + "." + product.rawValue
//               
//                // Verify the purchase of a Subscription
//                let purchaseResult = SwiftyStoreKit.verifySubscription(
//                    ofType: .autoRenewable, // or .nonRenewing (see below)
//                    productId: productId,
//                    inReceipt: receipt)
//                self.showAlert(alert: self.alertForVerifySubscription(result: purchaseResult))
//               // SwiftyStoreKit.verifySubscription(ofType: <#T##SubscriptionType#>, productId: <#T##String#>, inReceipt: <#T##ReceiptInfo#>, validUntil: <#T##Date#>)
//                
//                switch purchaseResult {
//                case .purchased(let expiryDate, let items):
//                    print("\(productId) is valid until \(expiryDate)\n\(items)\n")
//                case .expired(let expiryDate, let items):
//                    print("\(productId) is expired since \(expiryDate)\n\(items)\n")
//                case .notPurchased:
//                    print("The user has never purchased \(productId)")
//                }
//                
//            case .error(let error):
//                print("Receipt verification failed: \(error)")
//                self.fetchUpdatedReceipt()
//            }
//        }
//        
//
//        
//    }
}
