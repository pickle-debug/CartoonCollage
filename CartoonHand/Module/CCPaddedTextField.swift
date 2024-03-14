//
//  CCPaddedTextField.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/14.
//

import Foundation
import UIKit

class CCPaddedTextField: UITextField {
    // 设置左侧内边距的大小
    var leftPadding: CGFloat = 10
    
    // 为文本显示区域添加内边距
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + leftPadding, y: bounds.origin.y, width: bounds.size.width - leftPadding, height: bounds.size.height)
    }
    
    // 为文本编辑区域添加内边距
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // 如有需要，也可以为占位符文本添加内边距
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
