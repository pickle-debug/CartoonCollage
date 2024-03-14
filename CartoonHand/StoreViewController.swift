//
//  StoreViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit
import SwiftyStoreKit
import StoreKit
enum RegisteredPurchase : String {
    case coins100 = "100coin"
    case coins200 = "200coin"
    case coins500 = "500coin"
    case coins1000 = "1000coin"
    
}

class StoreViewController: UIViewController {
    
    let titleLabel = UILabel()
    let coinsCount = CCPaddingLabel()
//    var coinsModel = CoinsModel() // 创建 CoinsModel 的实例
    
    var coins100 = RegisteredPurchase.coins100
    var coins200 = RegisteredPurchase.coins200
    var coins500 = RegisteredPurchase.coins500
    var coins1000 = RegisteredPurchase.coins1000
    
    
    var tagCounter = 0
    var purchaseTagMap: [Int: RegisteredPurchase] = [:]

    //    override func viewDidAppear(_ animated: Bool) {
    ////        setUI()
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")
        
//        let titleLabel = UILabel()
//        self.view.addSubview(titleLabel)
//        titleLabel.text = "Store"
//        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
//        titleLabel.layout { view in
//            view.centerX == view.superview.centerX
//            view.top == view.superview.top + 60
//        }
//        
        titleLabel.text = "Store"
        titleLabel.font = UIFont.systemFont(ofSize: 24,weight: .heavy)
        titleLabel.textColor = .black

        self.navigationItem.titleView = titleLabel
//        self.navigationItem.ri
        
        CoinsModel.shared.coins.bind { [weak self] coins in
            DispatchQueue.main.async {
                self?.coinsCount.text = "\(coins ?? 0)"
            }
        }

        coinsCount.padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
        coinsCount.textAlignment = .center
        coinsCount.font = UIFont.systemFont(ofSize: 14,weight: .heavy)
        coinsCount.textColor = .black
        coinsCount.backgroundColor = UIColor.init(hexString: "#FFF5D9")
        coinsCount.layer.cornerRadius = 15
//        coinsCount.roundCorners(corners: [.topRight,.bottomRight], radius: 15)
        coinsCount.layer.masksToBounds = true
        // 设置自动调整字体大小以适应宽度
        coinsCount.adjustsFontSizeToFitWidth = true
        // 设置字体缩小的最小比例，这里设为0.5表示最小可以缩小到原字体的50%
        coinsCount.minimumScaleFactor = 0.5
//        self.view.addSubview(coinsCount)
        coinsCount.layout { view in
            view.height == 30
            view.width == 81
//            view.centerY == coinsIcon.centerY
//            view.leading == coinsIcon.leading
        }
        
        let coinsIcon = UIImageView()
        coinsIcon.image = UIImage(named: "coins")?.withRenderingMode(.alwaysOriginal)
        coinsCount.addSubview(coinsIcon)
        coinsIcon.layout { view in
            view.height == 30
            view.width == 30
            view.centerY == view.superview.centerY
            view.leading == view.superview.leading
        }
        let rightItem = UIBarButtonItem(customView: coinsCount)
        // 将UIBarButtonItem设置为navigationItem的rightBarButtonItem
        navigationItem.rightBarButtonItem = rightItem
        
        let topBanner = UIView()
        topBanner.backgroundColor = UIColor.init(hexString: "#FFDE4E")
        self.view.addSubview(topBanner)
        topBanner.layout { view in
            view.width == kScreenWidth
            view.height == 276
            view.top == view.superview.top
            view.centerX == view.superview.centerX

        }
        self.view.sendSubviewToBack(topBanner)
        
        let topStoreImage = UIImageView()
        topStoreImage.image = UIImage(named: "store")?.withRenderingMode(.alwaysOriginal)
        self.view.addSubview(topStoreImage)
        topStoreImage.layout { view in
            view.height == 213
            view.width == 343
            view.bottom == topBanner.bottom + 39
            view.centerX == view.superview.centerX
        }
        
        var lastButton: CCBuyButton? = nil
        for (coins, price) in priceDict {
            let buyButton = CCBuyButton(frame: .zero, price: "$\(price)", coins: "\(coins) coins")
            self.view.addSubview(buyButton)
            buyButton.layout { view in
                view.width == kScreenWidth * 0.9
                view.height == kScreenHeight * 0.11
                view.centerX == self.view.centerX
            }
            if let lastButton = lastButton {
                buyButton.layout { view in
                    view.top == lastButton.bottom + 5
                }
            } else {
                // 这是第一个按钮，所以它的顶部将相对于self.view的某个元素布局
                // 如果你有一个topStoreImage，可以将其顶部约束相对于这个image
                // 否则，你可以将其置于视图顶部，这里为了示例，我们假设它放置在视图的顶部
                buyButton.layout { view in
                    view.top == topStoreImage.bottom + 5
                }
            }
            // Button action setup
            if let purchaseType = purchaseOrder[coins] {
                buyButton.tag = tagCounter
                purchaseTagMap[tagCounter] = purchaseType
                buyButton.addTarget(self, action: #selector(buyButtonPressed(_:)), for: .touchUpInside)
                tagCounter += 1
            }
            // 更新lastButton引用为当前按钮
            lastButton = buyButton
        }
        // 遍历结束后，设置最后一个按钮的底部约束
        if let lastButton = lastButton {
            NSLayoutConstraint.activate([
                lastButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20) // 这里的-20是示例值，您可以根据实际需要调整
            ])
        }

        
    }
    // The selector method for button press action
    @objc func buyButtonPressed(_ sender: UIButton) {
            self.navigationController?.view.makeToastActivity(.center)
       
        
        if let purchaseType = purchaseTagMap[sender.tag] {
              purchase(purchase: purchaseType)
          }
    }
    
    //MARK: Get Info For Purchase Product
    func getInfo(purchase : RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue], completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            self.showAlert(alert: self.alertForProductRetrievalInfo(result: result))
            
            
        })
    }
    
    //MARK: Make Purchase
    func purchase(purchase : RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue, quantity: 1, atomically: true) { result in
            self.navigationController?.view.hideToastActivity()
            NetworkActivityIndicatorManager.networkOperationFinished()

            
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                self.showAlert(alert: self.alertForPurchaseResult(result: result))
                // 假设你的每种购买项对应一定数量的金币
                let coinsToAdd: Int
                switch purchase.productId {
                case bundleID + "." + RegisteredPurchase.coins100.rawValue:
                    coinsToAdd = 100
                case bundleID + "." + RegisteredPurchase.coins200.rawValue:
                    coinsToAdd = 200
                case bundleID + "." + RegisteredPurchase.coins500.rawValue:
                    coinsToAdd = 500
                case bundleID + "." + RegisteredPurchase.coins1000.rawValue:
                    coinsToAdd = 1000
                    // 添加其他case处理不同的购买项
                default:
                    coinsToAdd = 0
                }
                
                // 增加金币
                CoinsModel.shared.addCoins(coinsToAdd)
                            
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
    }
    
    
}
//MARK: Alerts Extensions
extension StoreViewController {
    
    func alertWithTitle(title : String, message : String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
        
    }
    func showAlert(alert : UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    func alertForProductRetrievalInfo(result : RetrieveResults) -> UIAlertController {
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
            
        }
        else if let invalidProductID = result.invalidProductIDs.first {
            return alertWithTitle(title: "Could not retreive product info", message: "Invalid product identifier: \(invalidProductID)")
        }
        else {
            let errorString = result.error?.localizedDescription ?? "Unknown Error. Please Contact Support"
            return alertWithTitle(title: "Could not retreive product info" , message: errorString)
            
        }
        
    }
    func alertForPurchaseResult(result : PurchaseResult) -> UIAlertController {
        switch result {
        case .success(let product):
            print("Purchase Succesful: \(product.productId)")
            
            return alertWithTitle(title: "Thank You", message: "Purchase completed")
        case .error(let error):
            print("Purchase Failed: \(error)")
            switch error.code {
            case .cloudServiceNetworkConnectionFailed:
                if (error as NSError).domain == SKErrorDomain {
                    return alertWithTitle(title: "Purchase Failed", message: "Check your internet connection or try again later.")
                }
                else {
                    return alertWithTitle(title: "Purchase Failed", message: "Unknown Error. Please Contact Support")
                }
            case .invalidOfferIdentifier:
                return alertWithTitle(title: "Purchase Failed", message: "this is not a valid product identifier")
            case .storeProductNotAvailable:
                return alertWithTitle(title: "Purchase Failed", message: "Product not found")
            case .paymentNotAllowed:
                return alertWithTitle(title: "Purchase Failed", message: "You are not allowed to make payments")
                
            default:
                return alertWithTitle(title: "Purchase failed", message: "Unknown error")
            }
        }
    }
    
    func alertForRestorePurchases(result : RestoreResults) -> UIAlertController {
        if result.restoreFailedPurchases.count > 0 {
            print("Restore Failed: \(result.restoreFailedPurchases)")
            return alertWithTitle(title: "Restore Failed", message: "Unknown Error. Please Contact Support")
        }
        else if result.restoredPurchases.count > 0 {
            return alertWithTitle(title: "Purchases Restored", message: "All purchases have been restored.")
            
        }
        else {
            return alertWithTitle(title: "Nothing To Restore", message: "No previous purchases were made.")
        }
        
    }
    func alertForVerifyReceipt(result: VerifyReceiptResult) -> UIAlertController {
        
        switch result {
        case.success(let receipt):
            return alertWithTitle(title: "Receipt Verified", message: "Receipt Verified Remotely")
        case .error(let error):
            switch error {
            case .noReceiptData:
                return alertWithTitle(title: "Receipt Verification", message: "No receipt data found, application will try to get a new one. Try Again.")
            default:
                return alertWithTitle(title: "Receipt verification", message: "Receipt Verification failed")
            }
        }
    }
    func alertForVerifySubscription(result: VerifySubscriptionResult) -> UIAlertController {
        switch result {
        case .purchased(let expiryDate):
            return alertWithTitle(title: "Product is Purchased", message: "Product is valid until \(expiryDate)")
        case .notPurchased:
            return alertWithTitle(title: "Not purchased", message: "This product has never been purchased")
        case .expired(let expiryDate):
            
            return alertWithTitle(title: "Product Expired", message: "Product is expired since \(expiryDate)")
        }
    }
    func alertForVerifyPurchase(result : VerifyPurchaseResult) -> UIAlertController {
        switch result {
        case .purchased:
            return alertWithTitle(title: "Product is Purchased", message: "Product will not expire")
        case .notPurchased:
            
            return alertWithTitle(title: "Product not purchased", message: "Product has never been purchased")
            
        }
        
    }
    
}

class NetworkActivityIndicatorManager : NSObject {
    
    private static var loadingCount = 0
    
    class func NetworkOperationStarted() {
        if loadingCount == 0 {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    class func networkOperationFinished(){
        if loadingCount > 0 {
            loadingCount -= 1
            
        }
        
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }
    }
}
