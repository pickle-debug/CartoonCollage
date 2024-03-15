//
//  CCPaddingLabel.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/13.
//

import Foundation
import UIKit

class CCPaddingLabel: UILabel {

    // 内边距属性
    var padding = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay() // 当内边距改变时重绘视图
        }
    }

    // 重写文本绘制方法以应用内边距
    override func drawText(in rect: CGRect) {
        // 根据内边距调整绘制文本的矩形区域
        let adjustedRect = rect.inset(by: padding)
        super.drawText(in: adjustedRect)
    }

    // 重写intrinsicContentSize来考虑内边距
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + padding.left + padding.right
        let height = size.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }

    // 重写sizeThatFits(_:)
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjustedSize = super.sizeThatFits(size)
        adjustedSize.width += padding.left + padding.right
        adjustedSize.height += padding.top + padding.bottom
        return adjustedSize
    }
}
