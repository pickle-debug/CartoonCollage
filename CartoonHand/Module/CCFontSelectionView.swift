//
//  CCFontSelectionView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/6.
//

import Foundation
import UIKit

class CCFontSelectionView: UIView {
    private var scrollView: UIScrollView!
    private var selectedButton: UIButton? // 追踪当前选中的按钮
    var onFontSelected: ((UIFont) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.layout { view in
            view.top == self.top
            view.bottom == self.bottom
            view.leading == self.leading
            view.trailing == self.trailing
        }

        var previousButton: UIButton? = nil
        
        for font in fonts {
            let button = UIButton()
            button.setTitle("Font", for: .normal)
            button.titleLabel?.font = font
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.init(hexString: "#687BFB")
            button.setTitleColor(.white, for: .normal)
            scrollView.addSubview(button)
            
            button.layout { view in
                view.height == 36
                view.width == 87
            }
            
            if let previousButton = previousButton {
                button.layout { view in
                    view.leading == previousButton.trailing + 12
                }
            } else {
                button.layout { view in
                    view.leading == scrollView.leading + 12
                }
            }
            
            previousButton = button
            
            // 为每个按钮添加点击事件
            button.addTarget(self, action: #selector(fontButtonTapped(_:)), for: .touchUpInside)
        }
        
        if let lastButton = previousButton {
            lastButton.layout { view in
                view.trailing == scrollView.trailing - 12
            }
        }
        
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    @objc func fontButtonTapped(_ sender: UIButton) {
        guard let font = sender.titleLabel?.font else { return }
        onFontSelected?(font)
        
        // 缩放选中的按钮，恢复之前选中的按钮
        if let selectedButton = selectedButton, selectedButton != sender {
            // 恢复之前的按钮
            UIView.animate(withDuration: 0.3) {
                selectedButton.transform = .identity
            }
        }
        
        // 缩放当前按钮
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        // 更新当前选中的按钮
        selectedButton = sender
    }
}
