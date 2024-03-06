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
    private let fonts: [UIFont] = [
        UIFont.systemFont(ofSize: 18),
        UIFont.boldSystemFont(ofSize: 18),
        UIFont.italicSystemFont(ofSize: 18),
        UIFont.systemFont(ofSize: 18, weight: .light),
        UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
    ]
    
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
            let button = UIButton(type: .system)
            button.setTitle("Font", for: .normal)
            button.titleLabel?.font = font
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.init(hexString: "#687BFB")
            button.titleLabel?.tintColor = .white
            scrollView.addSubview(button)
            
            button.layout { view in
                view.height == 36
                view.width == 87
//                view.top == scrollView.top
//                view.bottom == scrollView.bottom
            }
            
            if let previousButton = previousButton {
                button.layout { view in
                    view.leading == previousButton.trailing + 12
                }
            } else {
                button.layout { view in
                    view.leading == scrollView.leading - 12
                }
            }
            
            previousButton = button
        }
        
        
        if let lastButton = previousButton {
            lastButton.layout { view in
                view.trailing == scrollView.trailing - 12
            }
        }
        
        scrollView.showsHorizontalScrollIndicator = false
    }
}
