//
//  StoreViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class StoreViewController: UIViewController {

    let titleLabel = UILabel()
    let coinsCount = UILabel()


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
        
        let titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.text = "Store"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.layout { view in
            view.centerX == view.superview.centerX
            view.top == view.superview.top + 60
        }
        
        let topBanner = UIView()
        topBanner.backgroundColor = UIColor.init(hexString: "#FFDE4E")
        self.view.addSubview(topBanner)
        topBanner.layout { view in
            view.width == kScreenWidth
            view.height == 276
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
        
        let coinsIcon = UIImageView()
        coinsIcon.image = UIImage(named: "coins")?.withRenderingMode(.alwaysOriginal)
        self.view.addSubview(coinsIcon)
        coinsIcon.layout { view in
            view.height == 30
            view.width == 30
            view.centerY == titleLabel.centerY
            view.trailing == view.superview.trailing - 80
        }
        
        coinsCount.text = "50"
        coinsCount.textAlignment = .center
        coinsCount.font = UIFont.systemFont(ofSize: 14,weight: .heavy)
        coinsCount.textColor = .black
        coinsCount.backgroundColor = UIColor.init(hexString: "#FFF5D9")
        coinsCount.layer.cornerRadius = 15
        coinsCount.layer.masksToBounds = true
        self.view.addSubview(coinsCount)
        coinsCount.layout { view in
            view.height == 30
            view.width == 81
            view.centerY == coinsIcon.centerY
            view.leading == coinsIcon.leading
        }
        view.bringSubviewToFront(coinsIcon)


        var lastButton: CCBuyButton? = nil
        for i in 0..<4 {
            let buyButton = CCBuyButton(frame: .zero, price: "$1.99", coins: "100 coins")
            self.view.addSubview(buyButton)
            buyButton.layout { view in
                view.width == 340
                view.height == 93
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
                     // 更新lastButton引用为当前按钮
                     lastButton = buyButton
        }
        
    }
    

}
