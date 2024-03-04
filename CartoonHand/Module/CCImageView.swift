////
////  CCImageView.swift
////  CartoonHand
////
////  Created by Tanshuo on 2024/3/4.
////
//
//import Foundation
//import UIKit
//
//class CustomImageView: UIImageView {
//    let resizeIcon = UIImageView(image: UIImage(named: "resizeIcon")) // 你的大小调整图标
//    let deleteIcon = UIButton(type: .custom) // 删除按钮
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        setupUI()
//    }
//
//    private func setupUI() {
//        // 添加并设置大小调整图标
//        addSubview(resizeIcon)
//        resizeIcon.isUserInteractionEnabled = true
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleResizePan(_:)))
//        resizeIcon.addGestureRecognizer(panGesture)
//
//        // 添加并设置删除图标
//        addSubview(deleteIcon)
//        deleteIcon.setImage(UIImage(named: "deleteIcon"), for: .normal) // 你的删除图标
//        deleteIcon.addTarget(self, action: #selector(handleDeleteTap(_:)), for: .touchUpInside)
//
//        // 设置图标的frame或约束...
//
//        // 显示虚线边框
//        layer.borderStyle = .dashed
//        layer.borderColor = UIColor.gray.cgColor
//        layer.borderWidth = 2
//        // 注意：CALayer没有直接支持虚线边框的属性，你可能需要使用CAShapeLayer来绘制虚线边框
//    }
//
//    @objc private func handleResizePan(_ gesture: UIPanGestureRecognizer) {
//        // 实现拖动大小调整图标来放大缩小图片的逻辑
//    }
//
//    @objc private func handleDeleteTap(_ sender: UIButton) {
//        self.removeFromSuperview()
//    }
//}
