//
//  CCTextEditView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/4.
//

import Foundation
import UIKit

class CCBackgroundEditView: UIView {
    
    // 创建渐变色UIImage
    let gradientImages: [UIImage?] = [
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FED267"), UIColor.init(hexString: "#F5B44A")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#C6A0FC"), UIColor.init(hexString: "#AA84F3")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CEFFFF"), UIColor.init(hexString: "#AEFBFC")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CED6FF"), UIColor.init(hexString: "#AECDFC")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CEFFD9"), UIColor.init(hexString: "#AEFCBF")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FFCEF7"), UIColor.init(hexString: "#DEAEFC")])
    ]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        var previousView: UIView?
        
        for image in gradientImages {
            let view = UIView()
            if let image = image {
                           view.backgroundColor = UIColor(patternImage: image)
                       }           
            self.addSubview(view)
            
            view.layout { view in
                view.height == 46
                view.width == 46
            }
            view.layer.cornerRadius = 23.0
            if let previousView = previousView {
            
                view.layout { view in
                    view.leading == previousView.trailing + 20
                    view.centerY == self.centerY
                }
            } else {
                view.layout { view in
                    view.leading == self.leading + 20
                    view.centerY == self.centerY
                }
            }
            
            previousView = view
        }
    }
}
