//
//  CCTextEditViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/4.
//

import UIKit
//protocol CCTextEditViewDelegate: AnyObject {
//    func keyboardWillShow(in view: CCTextEditView, keyboardSize: CGRect)
//    func keyboardWillHide(in view: CCTextEditView)
//}
class CCTextEditView: UIView, UITextFieldDelegate {
    // 定义闭包类型的属性，这个闭包接受一个String参数并返回Void
    var textDidUpdate: ((CCSubmitText) -> Void)?
    
//    weak var delegate: CCTextEditViewDelegate?

    let colorLabel = UILabel()
    let fontLabel = UILabel()
    let textEditTF = UITextField()
    
    var selectedFont: UIFont = UIFont.systemFont(ofSize: 18)
    let textfontSelectView = CCFontSelectionView()
    var selectedColor: UIColor = .black
    private var selectedColorView: UIView?


    override init(frame: CGRect) {
        super.init(frame: frame)
//        commonInit()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
        setupUI()
    }
//    private func commonInit() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            delegate?.keyboardWillShow(in: self, keyboardSize: keyboardSize)
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        delegate?.keyboardWillHide(in: self)
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
    func setupUI() {
        // 创建并配置colorLabel和colorIcon
        let colorIcon = createIcon(named: "coloricon")
        let colorLabel = createLabel(text: "Color", fontSize: 18)
        self.addSubview(colorIcon)
        self.addSubview(colorLabel)
        
        colorIcon.layout { view in
            view.height == 20
            view.width == 20
            view.leading == self.leading + 16
            view.top == self.top + 61
        }
        colorLabel.layout { view in
            view.leading == colorIcon.trailing + 11
            view.centerY == colorIcon.centerY
        }
        
        let scrollView = UIScrollView()
        var totalWidth: CGFloat = 12 // 初始左边距

        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layout { view in
            view.height == 50
            view.width == self.width
            view.top == colorLabel.bottom + 9
            view.leading == self.leading
        }
        
        // 创建并配置fontLabel和fontIcon
        let fontIcon = createIcon(named: "fonticon")
        let fontLabel = createLabel(text: "Font Style", fontSize: 18)
        self.addSubview(fontIcon)
        self.addSubview(fontLabel)
        
        fontIcon.layout { view in
            view.height == 20
            view.width == 20
            view.leading == colorIcon.leading
            view.top == scrollView.bottom + 9 // Adjust the gap between items as needed
        }
        fontLabel.layout { view in
            view.leading == fontIcon.trailing + 11
            view.centerY == fontIcon.centerY
        }
        
        var previousView: UIView?
        for color in colors {
            let colorView = UIView()
            colorView.backgroundColor = color
            colorView.layer.borderColor = UIColor.init(hexString: "#A8A8A8").cgColor
            colorView.layer.borderWidth = 1
            scrollView.addSubview(colorView)
            
            // 启用用户交互
            colorView.isUserInteractionEnabled = true
            
            // 创建并添加手势识别器
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            colorView.addGestureRecognizer(tapGesture)
            
            colorView.layout { view in
                view.height == 36
                view.width == 36
            }
                if let previousView = previousView {
                    colorView.layout { view in
                        view.leading == previousView.trailing + 12
                        view.centerY == scrollView.centerY // Adjust the vertical position based on your layout
                    }
                } else {
                    colorView.layout { view in
                        view.leading == scrollView.leading + 12
                        view.centerY == scrollView.centerY // Adjust the vertical position based on your layout
                    }
            }
            totalWidth += 36 + 12
            previousView = colorView
        }
        
        // Ensure scrollView can scroll if content is larger than its frame
        if let lastView = previousView {
            totalWidth += 12
            scrollView.layout { view in
                view.trailing == lastView.trailing + 12
            }
        }
        
        scrollView.contentSize = CGSize(width: totalWidth, height: self.frame.height)
        
        self.addSubview(textfontSelectView)
        textfontSelectView.layout { view in
            view.height == 36
            view.width == self.width
            view.top == fontLabel.bottom + 9
            view.leading == self.leading + 16
        }
        self.addSubview(textEditTF)
        textEditTF.layer.borderWidth = 2
        textEditTF.delegate = self
        textEditTF.layer.borderColor = UIColor.black.cgColor
        textEditTF.layer.cornerRadius = 41 / 2
        textEditTF.layer.masksToBounds = true
        textEditTF.layout { view in
            view.height == 41
            view.width == 287
            view.leading == scrollView.leading + 16
            view.top == textfontSelectView.bottom + 26
        }
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("OK", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.backgroundColor = .clear
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 27,weight: .bold)
        self.addSubview(submitButton)
        submitButton.layout { view in
            view.height == 32
            view.width == 41
            view.centerY == textEditTF.centerY
            view.trailing == self.trailing - 18
        }
    }

    // Helper functions to reduce redundancy
    func createLabel(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        label.textColor = .black // 支持暗黑模式的文本颜色

        return label
    }

    func createIcon(named imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    // 实现手势识别器的动作方法
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedColorView = gesture.view else { return }

        // 缩放选中的视图，恢复之前选中的视图
        if let selectedColorView = selectedColorView, selectedColorView != tappedColorView {
            // 恢复之前的视图
            UIView.animate(withDuration: 0.3) {
                selectedColorView.transform = .identity
            }
        }
        
        // 如果当前视图没有放大，则放大之
        if tappedColorView.transform == .identity {
            UIView.animate(withDuration: 0.3) {
                tappedColorView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        } else {
            // 如果已经放大，恢复到原始大小
            UIView.animate(withDuration: 0.3) {
                tappedColorView.transform = .identity
            }
        }

        // 更新当前选中的视图
        selectedColorView = tappedColorView.transform == .identity ? nil : tappedColorView
        selectedColor = selectedColorView?.backgroundColor ?? .black
    }


    @objc private func submitButtonTapped() {
           // 当textField的内容变化时，触发闭包
        textfontSelectView.onFontSelected = { font in
            print("Selected font: \(font.fontName)")
            self.selectedFont = font
        }
//        print(textEditTF.text)
//        print(selectedColor ?? UIColor.black)
//        print(selectedFont ?? UIFont.systemFont(ofSize: 16))
        let submitText = CCSubmitText(text: textEditTF.text ?? "", font: selectedFont ?? UIFont.systemFont(ofSize: 16), color: selectedColor ?? UIColor.black)
        print(submitText)

        textDidUpdate?(submitText)
//        print(textDidUpdate)
       }

}
struct CCSubmitText {
    let text: String
    let font: UIFont
    let color: UIColor
    
    init(text: String, font: UIFont, color: UIColor) {
        self.text = text
        self.font = font
        self.color = color
    }
}
