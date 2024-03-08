//
//  constant.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/6.
//

import Foundation
import UIKit

//屏高
let kScreenHeight = UIScreen.main.bounds.size.height
//屏宽
let kScreenWidth = UIScreen.main.bounds.size.width
//贴纸图片数组
let stickerImages: [UIImage] = (0...14).compactMap { UIImage(named: "Stickers\($0)") }
//身体图片数组
let BodyImages: [UIImage] = (0...7).compactMap { UIImage(named: "CartoonBody\($0)") }
//动画头像图片数组
let HeadImages: [UIImage] = (0...7).compactMap { UIImage(named: "CartoonHead\($0)") }
//真人头像图片数组
let RealHeadImages: [UIImage] = (0...3).compactMap{ UIImage(named: "RealHead\($0)") }
//背景图片数组
let BackgroundImages: [UIImage] = (1...8).compactMap { UIImage(named: "Background\($0)") }

// 创建渐变色UIImage
let gradientImages: [UIImage?] = [
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FED267"), UIColor.init(hexString: "#F5B44A")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#C6A0FC"), UIColor.init(hexString: "#AA84F3")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CEFFFF"), UIColor.init(hexString: "#AEFBFC")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CED6FF"), UIColor.init(hexString: "#AECDFC")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CEFFD9"), UIColor.init(hexString: "#AEFCBF")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FFCEF7"), UIColor.init(hexString: "#DEAEFC")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#00EBFB"), UIColor.init(hexString: "#40BCFB")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#01EF93"), UIColor.init(hexString: "#0CFACC")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FC7C90"), UIColor.init(hexString: "#F9D361")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#AECAFA"), UIColor.init(hexString: "#7B7BFA")]),
    UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#F0F893"), UIColor.init(hexString: "#9BFDBE")])
]

// 创建字体颜色
let colors: [UIColor] = [UIColor.init(hexString: "#000000"),UIColor.init(hexString: "#FFFFFF"),UIColor.gray,UIColor.green,UIColor.purple,UIColor.init(hexString: "#EB5050"),UIColor.init(hexString: "#EA4FD1"),UIColor.init(hexString: "#624FEC"),UIColor.init(hexString: "#50BEEB"),UIColor.init(hexString: "#50EA87"),UIColor.init(hexString: "#EAC350")]

let fonts: [UIFont] = [
    UIFont.systemFont(ofSize: 18),
    UIFont.boldSystemFont(ofSize: 18),
    UIFont.italicSystemFont(ofSize: 18),
    UIFont.systemFont(ofSize: 18, weight: .light),
    UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
]
