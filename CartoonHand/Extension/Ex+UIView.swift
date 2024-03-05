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
}

/// 截图，并保存进手机相册
extension UIView {
    func snapshot() {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
        
        let targetSize = self.intrinsicContentSize
        self.bounds = CGRect(origin: .zero, size: targetSize)
        self.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        let image = renderer.image { _ in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
