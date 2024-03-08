//
//  CCRecordDetailViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/7.
//

import Foundation
import UIKit

class CCRecordDetailViewController: UIViewController {
//    var image: UIImage
//    var imageName: String

    var image: loaclSandBoxImage
    let imageView = UIImageView()
    

       // 自定义初始化方法
    init(image: loaclSandBoxImage) {
           self.image = image
//           self.imageName = imageName
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           // 创建一个带有自定义图标的UIBarButtonItem
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: "delete"), for: .normal) // 使用自己的图标名替换"yourCustomIcon"
           button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
           button.tintColor = .black
           button.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
           let item = UIBarButtonItem(customView: button)
           
           
           // 将UIBarButtonItem赋值给navigationItem的rightBarButtonItem
           self.navigationItem.rightBarButtonItem = item
           setUI()
           // 使用images数组来渲染UI
       }
    func setUI(){
        
        imageView.image = image.image
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
//        guard let image = image else { return }
        
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
        UIImageWriteToSavedPhotosAlbum(image.image, nil, nil, nil)
        print("saved")
    }
    @objc func deleteImage() {
        deleteImageFromSandbox(fileName: image.filename)
        
        // Optionally, remove the image from your imagesWithFilenames array
//        imagesWithFilenames.remove(at: index)
    }

    func deleteImageFromSandbox(fileName: String) {
        // 获取沙盒的Documents目录路径
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to access documents directory")
            return
        }
        
        // 拼接完整的文件路径
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        // 检查文件是否存在
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // 尝试删除文件
                try FileManager.default.removeItem(at: fileURL)
                print("File deleted successfully: \(fileName)")
            } catch {
                // 删除失败，处理错误
                print("Error deleting file: \(error.localizedDescription)")
            }
        } else {
            print("File does not exist: \(fileName)")
        }
    }

}
