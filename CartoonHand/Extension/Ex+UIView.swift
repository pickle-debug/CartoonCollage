//
//  Ex+UIView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/1.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setBackgroundImage(_ image: UIImage) {
          // 先移除可能已经存在的背景图层
          self.layer.sublayers?.filter { $0.name == "backgroundLayer" }.forEach { $0.removeFromSuperlayer() }
          
          // 创建一个新的 CALayer
          let backgroundLayer = CALayer()
          backgroundLayer.name = "backgroundLayer"
          // 将 UIImage 转换为 CGImage 并设置给 layer
          backgroundLayer.contents = image.cgImage
          // 设置图层大小与 UIView 相同
          backgroundLayer.frame = self.bounds
          // 将图层的内容模式设置为视图的内容模式，这里使用 .scaleAspectFill 来保持图片的宽高比
          backgroundLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
          // 插入新的图层到所有子图层的下方
          self.layer.insertSublayer(backgroundLayer, at: 0)
      }
}

// 扩展CGFloat，方便处理绝对值
extension CGFloat {
    func abs() -> CGFloat {
        return Swift.abs(self)
    }
}
