//
//  CCBuyButton.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/7.
//

import Foundation
import UIKit

class CCBuyButton: UIButton {
    private let centerLabel = UILabel()
    private let rightLabel = UILabel()
    private var price = String()
    private var coins = String()
    
    // CustomButton的初始化
    init(frame: CGRect,price: String,coins: String) {
        self.price = price
        self.coins = coins
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // 设置视图和标签
    private func setupViews() {
//        let backgroundImage = UIImage(named: "buyButtonBackground")
        // 设置背景图片
//        self.backgroundColor = UIColor(patternImage: UIImage(named: "buyButtonBackground")!.withRenderingMode(.alwaysTemplate))
        if let backgroundImage = UIImage(named: "buyButtonBackground")?.withRenderingMode(.alwaysOriginal) {
               self.setBackgroundImage(backgroundImage, for: .normal)
           }
        // 设置中间的标签
        centerLabel.textAlignment = .center
        centerLabel.textColor = .black // 可以根据需要调整
        centerLabel.text = coins
        centerLabel.font = UIFont.systemFont(ofSize: 24,weight: .heavy)
        self.addSubview(centerLabel)
        centerLabel.layout { view in
            view.height == self.height
            view.width == self.width
            view.centerX == self.centerX
            view.centerY == self.centerY
        }
        
        // 设置右边的标签
        rightLabel.textAlignment = .center
        rightLabel.text = price
        rightLabel.font = UIFont.systemFont(ofSize: 18,weight: .heavy)
        rightLabel.textColor = .white // 可以根据需要调整
        self.addSubview(rightLabel)
        rightLabel.layout { view in
            view.height == kScreenHeight * 0.1
            view.width == view.height
            view.trailing == self.trailing - kScreenWidth * 0.02
//            view.leading == self.leading + self.width * 0.8

            view.centerY == self.centerY
        }
    }
    
    // 提供设置标签文本的方法
    func setCenterLabelText(_ text: String) {
        centerLabel.text = text
    }
    
    func setRightLabelText(_ text: String) {
        rightLabel.text = text
    }
}
