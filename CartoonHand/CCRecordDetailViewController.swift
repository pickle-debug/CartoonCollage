//
//  CCRecordDetailViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/7.
//

import Foundation
import UIKit

class CCRecordDetailViewController: UIViewController {
    var image: UIImage?

    let imageView = UIImageView()
    

       // 自定义初始化方法
       init(image: UIImage) {
           self.image = image
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           
           setUI()
           // 使用images数组来渲染UI
       }
    func setUI(){
        
        imageView.image = image
        self.view.addSubview(imageView)
        imageView.layout { view in
            view.height == 343
            view.width == 343
            view.top == view.superview.top + 102
            view.centerX == view.superview.centerX
        }
        
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "shareIcon"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
        self.view.addSubview(shareButton)
        shareButton.layout { view in
            view.width == 80
            view.height == 80
            view.top == imageView.bottom + 77
            view.leading == view.superview.leading + 78
        }
        
        let saveButton = UIButton()
        saveButton.setImage(UIImage(named: "saveIcon"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        self.view.addSubview(saveButton)
        saveButton.layout { view in
            view.width == 80
            view.height == 80
            view.top == shareButton.top
            view.trailing == view.superview.trailing - 78
        }
    }
    
    @objc func shareImage() {
        guard let image = image else { return }
        
        // 初始化UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // 排除一些不需要的活动类型
        activityViewController.excludedActivityTypes = [.addToReadingList, .postToFlickr, .postToVimeo]
        
        // 适配iPad
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view // 适配iPad，配置源视图
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [] // 可以指定无箭头
        }
        
        // 展示视图控制器
        self.present(activityViewController, animated: true, completion: nil)
    }
    @objc func saveImage() {
        
    }

}
