//
//  CCRecordDetailViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/7.
//

import Foundation
import UIKit
import Photos

class CCRecordDetailViewController: UIViewController {

    var imageInSandBox: loaclSandBoxImage
    let imageView = UIImageView()
    

       // 自定义初始化方法
    init(image: loaclSandBoxImage) {
           self.imageInSandBox = image
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
        
        imageView.image = imageInSandBox.image
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
//        guard let image = imageInSandBox.image else { return }
        
        // 初始化UIActivityViewController
        let activityViewController = UIActivityViewController(activityItems: [imageInSandBox.image], applicationActivities: nil)
        
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
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    // 有权限，保存图片到相册
                    UIImageWriteToSavedPhotosAlbum(self.imageInSandBox.image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                case .denied, .restricted, .limited:
                    // 无权限
                    self.view.makeToast("Photo library access denied or restricted.", title: "Save failed")

                    print("Photo library access denied or restricted.")
                default:
                    // 未决定，一般不会执行到这里
                    break
                }
            }
        }
    }
    // 保存图片后的回调方法
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 保存失败
            self.view.makeToast("Error Save",duration: 1.0,position: .center)

            print("Error Saving: \(error.localizedDescription)")
        } else {
            // 保存成功
            self.view.makeToast("Image Saved Successfully",duration: 1.0,position: .center)

            print("Image Saved Successfully")
        }
    }
    
    @objc func deleteImage() {
        deleteImageFromSandbox(fileName: imageInSandBox.filename)
        self.navigationController?.popToRootViewController(animated: true)
        self.parent?.view.makeToast("Delete Successful", duration: 1.0, position: .center)
    }

    func deleteImageFromSandbox(fileName: String) {
        // 获取沙盒的Documents目录路径
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            self.view.makeToast("Failed to access documents directory",duration: 1.0,position: .center)

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
                self.view.makeToast("Image deleted successfully in documents directory",duration: 1.0,position: .center)

                print("File deleted successfully: \(fileName)")
            } catch {
                // 删除失败，处理错误
                self.view.makeToast("Image error deleting in documents directory",duration: 1.0,position: .center)

                print("Error deleting file: \(error.localizedDescription)")
            }
        } else {
            self.view.makeToast("Image does not exist in documents directory",duration: 1.0,position: .center)

            print("File does not exist: \(fileName)")
        }
    }

}
