//
//  CCTextEditViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/4.
//

import UIKit

class CCTextEditView: UIView {

    let colorLabel = UILabel()
    let fontLabel = UILabel()
    let textEditTF = UITextField()
    // 创建渐变色UIImage
    let colors: [UIColor] = [UIColor.init(hexString: "#000000"),UIColor.init(hexString: "#FFFFFF"),UIColor.init(hexString: "#EB5050"),UIColor.init(hexString: "#EA4FD1"),UIColor.init(hexString: "#EA4FD1"),UIColor.init(hexString: "#50BEEB"),UIColor.init(hexString: "#50EA87"),UIColor.init(hexString: "#EAC350")]
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
        
        let colorLabel = UILabel()
        let coloricon = UIImageView()
        colorLabel.text = "Color"
        colorLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        coloricon.image = UIImage(named: "coloricon")
        self.addSubview(coloricon)
        self.addSubview(colorLabel)
        coloricon.layout { view in
            view.height == 20
            view.width == 20
            view.leading == self.leading + 16
            view.top == self.top + 61
        }
        colorLabel.layout { view in
            view.height == 21
            view.width == 48
            view.leading == coloricon.trailing + 11
            view.centerY == coloricon.centerY

        }
        
        let fontLabel = UILabel()
        let fonticon = UIImageView()
        fontLabel.text = "Font Style"
        fontLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        fonticon.image = UIImage(named: "fonticon")
        self.addSubview(fonticon)
        self.addSubview(fontLabel)

        fonticon.layout { view in
            view.height == 20
            view.width == 20
            view.leading == self.leading + 16
            view.top == self.top + 140
        }
        fontLabel.layout { view in
            view.height == 21
            view.width == 90
            view.leading == fonticon.trailing + 1
            view.centerY == fonticon.centerY
        }
        
        
        
        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            self.addSubview(view)
            
            view.layout { view in
                view.height == 36
                view.width == 36
            }
            if let previousView = previousView {
            
                view.layout { view in
                    view.leading == previousView.trailing + 12
                    view.top == coloricon.bottom + 9
                }
            } else {
                view.layout { view in
                    view.leading == self.leading + 12
                    view.top == coloricon.bottom + 9
                }
            }
            
            previousView = view
        }
        
        self.addSubview(textEditTF)
        textEditTF.layer.borderWidth = 2
        textEditTF.layer.borderColor = UIColor.black.cgColor
        textEditTF.layer.cornerRadius = 41 / 2
        textEditTF.layer.masksToBounds = true
        textEditTF.layout { view in
            view.height == 41
            view.width == 287
            view.leading == self.leading + 16
            view.bottom == self.bottom - 34
        }
    }

}
