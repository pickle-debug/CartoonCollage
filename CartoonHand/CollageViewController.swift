//
//  CartoonHeadCollageViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit
import Photos

class CollageViewController: UIViewController,CCBackgroundEditViewDelegate{
    
    
    let contentView = UIView()
    private var currentIndex = 0
    
    var images: [UIImage]
    
    let editView = UIView()
    
    private var currentTextString = ""
//    var coinsModel = CoinsModel()
    let segmentItem = ["Body","Head","Background","Sticker","Text"]
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // 自定义初始化方法
    init(images: [UIImage]) {
        self.images = images
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var control: CCSegmentedControl = {
        let items: [UIImage] = segmentItem.compactMap { itemName in
            if let image = UIImage(named: itemName) {
                return image.withRenderingMode(.alwaysOriginal)
            }
            return nil
        }
        let control = CCSegmentedControl(items: items)
                
        //  默认选中第一项
        control.selectedSegmentIndex = 0
        // 设置选中时的背景色为透明
        //        control.selectedSegmentTintColor = UIColor.clear
        //  添加值改变监听
        control.addTarget(self, action: #selector(segmentDidchange), for: .valueChanged)
        return control
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()

        self.view.addSubview(titleLabel)
        titleLabel.text = "Hand"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.layout { view in
            view.centerX == view.superview.centerX
            view.top == view.superview.top + 60
        }
        
        // 创建一个带有自定义图标的UIBarButtonItem
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrow.down.to.line"), for: .normal) // 使用自己的图标名替换"yourCustomIcon"
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.tintColor = .black
        button.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        
        
        // 将UIBarButtonItem赋值给navigationItem的rightBarButtonItem
        self.navigationItem.rightBarButtonItem = item
        
        setUI()

    }
    
    func setUI(){
                
        self.view.addSubview(contentView)
        contentView.backgroundColor = UIColor.white
        contentView.layout { view in
            view.width == 343
            view.height == 343
            view.centerX == view.superview.centerX
            view.top == view.superview.top + 102
        }
        self.view.addSubview(editView)
        editView.layer.cornerRadius = 60
        editView.backgroundColor = .white
        editView.layout { view in
            view.width == view.superview.width
            view.height == 300
            view.top == view.superview.bottom - 307
            view.centerX == view.superview.centerX
        }
        
        self.view.addSubview(control)
        control.backgroundColor = UIColor.init(hexString: "#687BFB")
        control.layer.cornerRadius = 37.0
        
        control.layer.masksToBounds = true
        control.clipsToBounds = true
        control.layout { view in
            view.width == 329
            view.height == 72
            view.centerX == view.superview.centerX
            view.centerY == editView.top
        }
        
        setImageEditUI(index: 0)
    }
    func setImageEditUI(index: Int) {
        while !editView.subviews.isEmpty {
            editView.subviews[0].removeFromSuperview()
        }
        switch index {
        case 0:
            let imageSelectView = CCImageSelectView(frame: .zero, images: BodyImages)
            editView.addSubview(imageSelectView)
            imageSelectView.layout { view in
                view.width == editView.width
                view.height == editView.height
                view.top == editView.top
                view.centerX == editView.centerX
            }
            // 配置闭包来接收选中的图片
            imageSelectView.selectedPic = { [weak self] selectedImage in
                // 在这里，我们更新imageView来展示选中的图片
                self!.addContentToContentView(selectedImage, matchContentViewSize: false)
                print(selectedImage)
            }
            
        case 1:
            let imageSelectView = CCImageSelectView(frame: .zero, images: images)
            editView.addSubview(imageSelectView)
            imageSelectView.layout { view in
                view.width == editView.width
                view.height == editView.height
                view.top == editView.top
                view.centerX == editView.centerX
            }
            // 配置闭包来接收选中的图片
            imageSelectView.selectedPic = { [weak self] selectedImage in
                // 在这里，我们更新imageView来展示选中的图片
                self!.addContentToContentView(selectedImage, matchContentViewSize: false)
            }
        case 2:
            let colorView = CCBackgroundEditView()
            editView.addSubview(colorView)
            colorView.delegate = self
            
            colorView.layout { view in
                view.height == 307
                view.width == editView.width
                view.centerX == editView.centerX
            }
            colorView.selectedBackground = { [weak self] selectedImage in
                    self!.setBackgroundView(selectedImage)
            }
            
        case 3:
            let imageSelectView = CCImageSelectView(frame: .zero, images: stickerImages)
            editView.addSubview(imageSelectView)
            imageSelectView.layout { view in
                view.width == editView.width
                view.height == editView.height
                view.top == editView.top
                view.centerX == editView.centerX
            }
            // 配置闭包来接收选中的图片
            imageSelectView.selectedPic = { [weak self] selectedImage in
                // 在这里，我们更新imageView来展示选中的图片
                self!.addContentToContentView(selectedImage, matchContentViewSize: false)
            }
        case 4:
            let textEdit = CCTextEditView()
            editView.addSubview(textEdit)
            textEdit.layout { view in
                view.width == editView.width
                view.height == editView.height
                view.top == editView.top
                view.centerX == editView.centerX
            }
            // 配置闭包来接收选中的图片
            textEdit.textDidUpdate = { [weak self] selectText in
                // 在这里，我们更新imageView来展示选中的图片
                self!.addContentToContentView(selectText, matchContentViewSize: true)
            }
        default:
            0
        }
    }
    
    // 实现代理方法
    func ccBackgroundEditViewDidRequestImagePicker(_ view: CCBackgroundEditView) {
        showImagePicker()
    }
    
    // 定义点击事件的方法
    @objc func saveImage() {
        // 在这里实现按钮点击后你想执行的操作
        saveContentViewToImage(contentView: contentView)
        print(CoinsModel.shared.coins.value)
        CoinsModel.shared.spendCoins(5)
        print(CoinsModel.shared.coins.value)
//        CoinsModel.shared.addCoins(5)
//        print(CoinsModel.shared.coins.value)
    }
    
    @objc func segmentDidchange(_ segmented: UISegmentedControl) {
        let selectedItem = segmentItem[segmented.selectedSegmentIndex]
        if let highlightedImage = UIImage(named: "\(selectedItem)_highlight") {
            segmented.setImage(highlightedImage.withRenderingMode(.alwaysOriginal), forSegmentAt: segmented.selectedSegmentIndex)
        }
        setImageEditUI(index: segmented.selectedSegmentIndex)
        
    }
    
    // 为单个subview添加拖动手势
    func addGestures(to view: UIView) {
        // 添加拖动手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)

        view.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        view.addGestureRecognizer(pinchGesture)
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
        guard let viewToMove = gesture.view else { return }
        let translation = gesture.translation(in: viewToMove.superview)
        let proposedNewCenter = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)

        // 计算拖动后的view的frame
        let halfWidth = viewToMove.bounds.width / 2
        let halfHeight = viewToMove.bounds.height / 2
        let proposedNewFrame = CGRect(x: proposedNewCenter.x - halfWidth, y: proposedNewCenter.y - halfHeight, width: viewToMove.bounds.width, height: viewToMove.bounds.height)
        
        // 确保新frame不会超出contentView的边界
        guard let superviewBounds = viewToMove.superview?.bounds else { return }
        let clampedX = max(halfWidth, min(superviewBounds.width - halfWidth, proposedNewFrame.midX))
        let clampedY = max(halfHeight, min(superviewBounds.height - halfHeight, proposedNewFrame.midY))

        if gesture.state == .changed {
            viewToMove.center = CGPoint(x: clampedX, y: clampedY)
            gesture.setTranslation(.zero, in: viewToMove.superview)
        }
        
    }
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
           guard gesture.view != nil else { return }

           if gesture.state == .began || gesture.state == .changed {
               // 根据捏合手势的缩放比例调整视图的缩放
               gesture.view?.transform = (gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale))!
               // 重置缩放比例，这样缩放是增量的
               gesture.scale = 1.0
           }
       }

    func addIconsTo(view: UIView) {
        let deleteIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.addSubview(deleteIcon)
        view.bringSubviewToFront(deleteIcon)
        deleteIcon.setImage(UIImage(systemName: "multiply"), for: .normal)
        deleteIcon.tintColor = UIColor.black
        deleteIcon.addTarget(self, action: #selector(deleteSubview(_:)), for: .touchUpInside)
        deleteIcon.tag = 999
    }
    
    func setDeleteIconsHidden(_ hidden: Bool) {
        // 假设deleteIcon是每个subview的子视图的标签
        for subview in contentView.subviews {
            // 根据您如何添加deleteIcon，找到并设置其isHidden属性
            // 这里是一个简化的示例，您的实现可能会有所不同
            if let deleteIcon = subview.subviews.first(where: { $0.tag == 999 }) { // 假设您给deleteIcon设置了特定的tag
                deleteIcon.isHidden = hidden
            }
        }
    }


    @objc func deleteSubview(_ sender: UIButton) {
        print("delete")
        sender.superview?.removeFromSuperview()
    }
    
    @objc func backButtonTapped() {
        // 返回上一个视图控制器
        navigationController?.popViewController(animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    func addContentToContentView(_ content: Any, matchContentViewSize: Bool) {
        if let image = content as? UIImage {
            // 原有的添加图片逻辑
            let selectedImageView = UIImageView(image: image)
            contentView.addSubview(selectedImageView)

            if matchContentViewSize {
                selectedImageView.layout { view in
                    view.height == contentView.height
                    view.width == contentView.width
                    view.centerX == contentView.centerX
                    view.centerY == contentView.centerY
                }
            } else {
                selectedImageView.layout { view in
                    view.centerX == contentView.centerX
                    view.centerY == contentView.centerY
                }
            }

            // 通用配置，为imageView添加手势和icon
            if !matchContentViewSize {
                addGestures(to: selectedImageView)
                addIconsTo(view: selectedImageView)
            }
        } else if let submitText = content as? CCSubmitText {
            print(submitText.text)
            print(submitText.font)
            print(submitText.color)
            // 新添加的处理文本逻辑
            let label = UILabel()
            label.text = submitText.text
            label.font = submitText.font
            label.textColor = submitText.color
            
            contentView.addSubview(label)
            
            // 根据matchContentViewSize标志来设置label布局
            if matchContentViewSize {
                label.layout { view in
                    view.height == 30
                    view.width == 200
                    view.centerX == contentView.centerX
                    view.centerY == contentView.centerY
                }
            } else {
                // 如果不需要匹配contentView的大小，可能需要自定义布局
                label.layout { view in
                    // 这里的布局取决于您具体的需求，例如仅设置中心对齐
                    view.centerX == contentView.centerX
                    view.centerY == contentView.centerY
                }
            }
            
            addGestures(to: label)
            addIconsTo(view: label)
            // 根据需要为label添加手势、背景等
            // 注意：这里根据您的需求可能需要进行调整
        } else {
            // 处理其他类型的content或抛出错误
            print("Unsupported content type")
        }
    }

    func setBackgroundView(_ image: UIImage?){
        guard let background = image else { return }
        let backgroundView = UIImageView(image: background)
        print(image)
        backgroundView.image = image
        backgroundView.contentMode = .scaleAspectFill // 或者选择其他适合的contentMode
        backgroundView.clipsToBounds = true
        contentView.addSubview(backgroundView)
        contentView.sendSubviewToBack(backgroundView) // 确保背景视图位于最底层
        backgroundView.layout { view in
            view.leading == contentView.leading
            view.trailing == contentView.trailing
            view.top == contentView.top
            view.bottom == contentView.bottom
        }
    }
}
extension CollageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 显示图片选择器
    func showImagePicker() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.presentPicker()
                }
            }
        } else if status == .authorized {
            self.presentPicker()
        } else {
            // 处理未获得权限的情况
        }
    }
    
    func presentPicker() {
        DispatchQueue.main.async {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    
    // 实现UIImagePickerControllerDelegate方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            // 使用选取的图片作为背景
            setBackgroundView(image)
            
            // 如果您还想将图片保存到相册，可以保留下面的代码
//            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func renderContentViewToImage(_ contentView: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: contentView.bounds)
        return renderer.image { context in
            contentView.layer.render(in: context.cgContext)
        }
    }


    // 保存图片后的回调方法
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 保存失败
            print("Error Saving: \(error.localizedDescription)")
        } else {
            // 保存成功
            print("Image Saved Successfully")
        }
    }
    
    func saveContentViewToImage(contentView: UIView) {
        
        // 隐藏deleteIcon
        setDeleteIconsHidden(true)

        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(contentView.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // 将contentView的层渲染到上下文
        contentView.layer.render(in: context)
        guard let capturedImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        
        // 结束图形上下文
        UIGraphicsEndImageContext()
        
        // 显示deleteIcon
        setDeleteIconsHidden(false)
        //        let capturedImage = image
        // 保存图片到相册
        UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
        //               guard isNeedToSaveSandBox else {return}
        // 生成唯一文件名
        let fileName = "capturedImage_\(Date().timeIntervalSince1970).png"
        if let data = capturedImage.pngData() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let filePath = documentsDirectory.appendingPathComponent(fileName)
            
            do {
                // 写入数据到沙盒路径
                try data.write(to: filePath)
                print("Saved image to: \(filePath)")
            } catch {
                print("Could not save image: \(error)")
            }
        }
    }


}
