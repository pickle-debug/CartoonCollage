////
////  CartoonHeadCollageViewController.swift
////  CartoonHand
////
////  Created by Tanshuo on 2024/2/29.
////
//
//import UIKit
//import Photos
//import Toast_Swift
//class CollageViewController: UIViewController,CCBackgroundEditViewDelegate{
//    
//    
//    let contentView = UIView()
//    private var currentIndex = 0
//    
//    var images: [UIImage]
//    var paidStartIndex: Int?
//    var category: ImageManager.ImageCategory
//    let editAndControlView = UIView()
//
//    
//    var paidImageCount: Int = 0
//    let editView = UIView()
//
////    var EditAndControlViewOriginY = Double()
//    var editAndControlViewBottomConstraint: NSLayoutConstraint?
////    var editAndControlViewTopConstraint: NSLayoutConstraint?
//    var lastAddedImageView: PaidImageView?
//
//
//    
//    private var currentTextString = ""
////    var coinsModel = CoinsModel()
//    let segmentItem = ["Body","Head","Background","Sticker","Text"]
////    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    // 自定义初始化方法
//    init(images: [UIImage],paidStartIndex:Int?,category:ImageManager.ImageCategory) {
//        self.images = images
//        self.paidStartIndex = paidStartIndex
//        self.category = category
//        super.init(nibName: nil, bundle: nil)
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private lazy var control: CCSegmentedControl = {
//        let items: [UIImage] = segmentItem.compactMap { itemName in
//            if let image = UIImage(named: itemName) {
//                return image.withRenderingMode(.alwaysOriginal)
//            }
//            return nil
//        }
//        let control = CCSegmentedControl(items: items)
//                
//        //  默认选中第一项
//        control.selectedSegmentIndex = 0
//        // 设置选中时的背景色为透明
//        //        control.selectedSegmentTintColor = UIColor.clear
//        //  添加值改变监听
//        control.addTarget(self, action: #selector(segmentDidchange), for: .valueChanged)
//        return control
//    }()
//    
//    override func viewDidAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = true
//        showFirstTimeAlertIfNeeded()
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let titleLabel = UILabel()
//
//        titleLabel.text = "Hand"
//        titleLabel.font = UIFont.systemFont(ofSize: 24,weight: .heavy)
//        titleLabel.textColor = .black
//
//        self.navigationItem.titleView = titleLabel
//        
//        // 创建一个带有自定义图标的UIBarButtonItem
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(systemName: "arrow.down.to.line"), for: .normal) // 使用自己的图标名替换"yourCustomIcon"
//        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
//        let item = UIBarButtonItem(customView: button)
//        
//        
//        // 将UIBarButtonItem赋值给navigationItem的rightBarButtonItem
//        self.navigationItem.rightBarButtonItem = item
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        
//        
//        setUI()
//
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    
//    func setUI(){
//                
//        self.view.addSubview(contentView)
//        contentView.backgroundColor = UIColor.white
//        contentView.layout { view in
////            view.leading == view.superview.leading + 16
////            view.trailing == view.superview.trailing - 16
//            view.top == view.superview.top + kNavBarFullHeight
//            view.height == kScreenHeight * 0.42
//            view.width == view.height
//            view.centerX == view.superview.centerX
//        }
//        self.view.addSubview(editAndControlView)
//        let topOffest = kNavBarFullHeight + kScreenHeight * 0.5
//        editAndControlView.translatesAutoresizingMaskIntoConstraints = false
//        editAndControlView.layout { view in
//            view.width == view.superview.width
//            view.height == kScreenHeight * 0.4
////            view.top == view.superview.top + topOffest
//        }
////        editAndControlViewTopConstraint = editAndControlView.topAnchor.constraint(equalTo: view.topAnchor)
//
//        editAndControlViewBottomConstraint = editAndControlView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        editAndControlViewBottomConstraint?.isActive = true
//
//        editAndControlView.addSubview(control)
//
//        control.backgroundColor = UIColor.init(hexString: "#687BFB")
//        control.layer.masksToBounds = true
//        control.layer.cornerRadius = 37.0
//        control.clipsToBounds = true
//        control.layout { view in
//            view.top == view.superview.top
//            view.leading == view.superview.leading + 20
//            view.trailing == view.superview.trailing - 20
//            view.height == 72
//            //            view.centerX == view.superview.centerX
//            //            view.centerY == editView.top
//        }
//
//        editAndControlView.addSubview(editView)
//        editView.layer.cornerRadius = 60
//        editView.backgroundColor = .white
//        editView.layout { view in
//            view.width == kScreenWidth
//            view.height == kScreenHeight * 0.5
//            view.top == control.centerY
//            view.centerX == view.superview.centerX
//        }
//        editAndControlView.bringSubviewToFront(control)
////        EditAndControlViewOriginY = self.EditAndControlView.frame.origin.y
////        print(EditAndControlViewOriginY)
//        
//        setImageEditUI(index: 0)
//    }
//    func setImageEditUI(index: Int) {
//        while !editView.subviews.isEmpty {
//            editView.subviews[0].removeFromSuperview()
//        }
//        switch index {
//        case 0:
//            let category = ImageManager.ImageCategory.body // 选择图片类别
//            let (sortedImages, paidStartIndex) = ImageManager.shared.sortedImagesWithPaidIndex(for: category)
//            let imageSelectView = CCImageSelectView(frame: .zero, images: sortedImages,paidStartIndex: paidStartIndex)
////            let imageSelectView = CCImageSelectView(frame: .zero, images: BodyImages)
//            editView.addSubview(imageSelectView)
//            imageSelectView.layout { view in
//                view.width == editView.width
//                view.height == editView.height
//                view.top == editView.top
//                view.centerX == editView.centerX
//            }
//            // 配置闭包来接收选中的图片
//            imageSelectView.selectedPic = { [weak self] selectedImage in
//                guard let strongSelf = self else { return }
//                   
//                let imageView = PaidImageView(image: selectedImage!.image)
//                   imageView.isPaid = selectedImage!.isPaid
//                   imageView.contentMode = .scaleAspectFit
//                   imageView.isUserInteractionEnabled = true
//                   
//                
//                strongSelf.addContentToContentView(imageView, matchContentViewSize: false)
//                   if imageView.isPaid {
//                       strongSelf.paidImageCount += 1
//                       print(strongSelf.paidImageCount)
//
//                   }
//            }
//            
//        case 1:
//            let imageSelectView = CCImageSelectView(frame: .zero, images: images,paidStartIndex: paidStartIndex)
//            editView.addSubview(imageSelectView)
//            imageSelectView.layout { view in
//                view.width == editView.width
//                view.height == editView.height
//                view.top == editView.top
//                view.centerX == editView.centerX
//            }
//            
//            // 配置闭包来接收选中的图片
//            imageSelectView.selectedPic = { [weak self] selectedImage in
//                guard let strongSelf = self else { return }
//                   
//                let imageView = PaidImageView(image: selectedImage!.image)
//                   imageView.isPaid = selectedImage!.isPaid
//                   imageView.contentMode = .scaleAspectFit
//                   imageView.isUserInteractionEnabled = true
//                   
//                
//                strongSelf.addContentToContentView(imageView, matchContentViewSize: false)
//                   if imageView.isPaid {
//                       strongSelf.paidImageCount += 1
//                       print(strongSelf.paidImageCount)
//
//                   }
//            }
//        case 2:
//            let colorView = CCBackgroundEditView()
//            editView.addSubview(colorView)
//            colorView.delegate = self
//            
//            colorView.layout { view in
//                view.height == 307
//                view.width == editView.width
//                view.centerX == editView.centerX
//            }
//            colorView.selectedBackground = { [weak self] selectedImage in
//                    self!.setBackgroundView(selectedImage)
//            }
//            
//        case 3:
//            let category = ImageManager.ImageCategory.sticker // 选择图片类别
//            let (sortedImages, paidStartIndex) = ImageManager.shared.sortedImagesWithPaidIndex(for: category)
//            let imageSelectView = CCImageSelectView(frame: .zero, images: sortedImages,paidStartIndex: paidStartIndex)
//            editView.addSubview(imageSelectView)
//            imageSelectView.layout { view in
//                view.width == editView.width
//                view.height == editView.height
//                view.top == editView.top
//                view.centerX == editView.centerX
//            }
//            // 配置闭包来接收选中的图片
//            // 配置闭包来接收选中的图片
//            imageSelectView.selectedPic = { [weak self] selectedImage in
//                guard let strongSelf = self else { return }
//                   
//                let imageView = PaidImageView(image: selectedImage!.image)
//                   imageView.isPaid = selectedImage!.isPaid
//                   imageView.contentMode = .scaleAspectFit
//                   imageView.isUserInteractionEnabled = true
//                   
//                
//                strongSelf.addContentToContentView(imageView, matchContentViewSize: false)
//                   if imageView.isPaid {
//                       strongSelf.paidImageCount += 1
//                       print(strongSelf.paidImageCount)
//
//                   }
//            }
//        case 4:
//            let textEdit = CCTextEditView()
//            editView.addSubview(textEdit)
//            textEdit.layout { view in
//                view.width == editView.width
//                view.height == editView.height
//                view.top == editView.top
//                view.centerX == editView.centerX
//            }
//            // 配置闭包来接收选中的图片
//            textEdit.textDidUpdate = { [weak self] selectText in
//                // 在这里，我们更新imageView来展示选中的图片
//                self!.addContentToContentView(selectText, matchContentViewSize: true)
//            }
//        default:
//            0
//        }
//    }
//    
//    // 实现代理方法
//    func ccBackgroundEditViewDidRequestImagePicker(_ view: CCBackgroundEditView) {
//        showImagePicker()
//    }
//    
//    // 定义点击事件的方法
//    @objc func saveImage() {
//        // Check if contentView has subviews
//        guard !contentView.subviews.isEmpty else {
//            // Popup “The canvas is still blank, please edit it first” message
//            self.view.makeToast("The canvas is still blank, please edit it first",duration: 1.0,position: .center)
//
////            showAlertWith(message: "The canvas is still blank, please edit it first")
//            return
//        }
//
//        // If there are no paid contents used (paidImageCount == 0), directly save the image without deducting coins.
//        if paidImageCount == 0 {
//            saveContentViewToImage(contentView: contentView)
//        } else {
//            // When paid contents are used, confirm if user wants to spend coins.
//            guard let coinsValue = CoinsModel.shared.coins.value, coinsValue > 0 else {
//                print("Coins value not set or insufficient coins")
//                self.view.makeToast("Insufficient coins, please go to the store to purchase coins.",duration: 1.0,position: .center)
//                return
//            }
//
//            let cost = paidImageCount * 5 // Calculate the cost based on used paid contents
//            
//            // Check if there are enough coins to cover the cost
//            if coinsValue < cost {
//                self.view.makeToast("Insufficient coins, please go to the store to purchase coins.",duration: 1.0,position: .center)
//            } else {
//                confirmSpendCoins(cost: cost)
//            }
//        }
//    }
//
//
//    func confirmSpendCoins(cost: Int) {
//        let message = "Do you want to spend \(cost) coins to save the image?"
//        let alert = UIAlertController(title: "Save Image", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
//            CoinsModel.shared.spendCoins(cost)
//            self?.saveContentViewToImage(contentView: self?.contentView ?? UIView())
//        }))
//        present(alert, animated: true)
//    }
//
//    func showAlertWith(message: String) {
//        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default))
//        present(alert, animated: true, completion: nil)
//    }
//
//
//    
//    @objc func segmentDidchange(_ segmented: UISegmentedControl) {
//        let selectedItem = segmentItem[segmented.selectedSegmentIndex]
//        if let highlightedImage = UIImage(named: "\(selectedItem)_highlight") {
//            segmented.setImage(highlightedImage.withRenderingMode(.alwaysOriginal), forSegmentAt: segmented.selectedSegmentIndex)
//        }
//        setImageEditUI(index: segmented.selectedSegmentIndex)
//        
//    }
//    
//    // 为单个subview添加拖动手势
//    func addGestures(to view: UIView) {
//        // 添加拖动手势
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        view.addGestureRecognizer(panGesture)
//
//        view.isUserInteractionEnabled = true
//        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
//        view.addGestureRecognizer(pinchGesture)
//    }
//
//    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        guard let viewToMove = gesture.view else { return }
//        let translation = gesture.translation(in: viewToMove.superview)
//        
//        if gesture.state == .changed {
//            let proposedNewCenter = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
//            
//            // 获取视图的放大后的实际尺寸
//            let scaledWidth = viewToMove.frame.width
//            let scaledHeight = viewToMove.frame.height
//            
//            // 获取父视图的尺寸
//            guard let superviewBounds = viewToMove.superview?.bounds else { return }
//
//            // 计算拖动后视图的边界，以确保不会超出父视图
//            let minX = scaledWidth / 2
//            let maxX = superviewBounds.width - minX
//            let minY = scaledHeight / 2
//            let maxY = superviewBounds.height - minY
//            
//            let clampedX = max(minX, min(maxX, proposedNewCenter.x))
//            let clampedY = max(minY, min(maxY, proposedNewCenter.y))
//            
//            viewToMove.center = CGPoint(x: clampedX, y: clampedY)
//            gesture.setTranslation(.zero, in: viewToMove.superview)
//        }
//    }
//
//    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
//        guard let viewToScale = gesture.view, let superview = viewToScale.superview else { return }
//
//        if gesture.state == .began || gesture.state == .changed {
//            // 预计算缩放后的视图尺寸
//            let scale = gesture.scale
//            let currentTransform = viewToScale.transform
//            let newTransform = currentTransform.scaledBy(x: scale, y: scale)
//            let currentFrame = viewToScale.frame
//            let newFrame = viewToScale.bounds.applying(newTransform)
//            let scaledWidth = newFrame.width
//            let scaledHeight = newFrame.height
//
//            // 确保缩放后的尺寸不会超出父视图的尺寸
//            let fitsInSuperview = scaledWidth <= superview.bounds.width && scaledHeight <= superview.bounds.height
//            
//            if fitsInSuperview {
//                // 应用新的缩放比例
//                viewToScale.transform = newTransform
//                // 重置缩放比例，这样缩放是增量的
//                gesture.scale = 1.0
//            } else {
//                // 调整scale使得缩放后尺寸适应父视图边界
//                let widthRatio = superview.bounds.width / currentFrame.width
//                let heightRatio = superview.bounds.height / currentFrame.height
//                let minRatio = min(widthRatio, heightRatio)
//                viewToScale.transform = currentTransform.scaledBy(x: minRatio, y: minRatio)
//            }
//        }
//    }
//
//    func addIconsTo(view: UIView) {
//        let deleteIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
//        view.addSubview(deleteIcon)
//        view.bringSubviewToFront(deleteIcon)
//        deleteIcon.setImage(UIImage(named: "removeIcon"), for: .normal)
//        deleteIcon.tintColor = UIColor.black
//        deleteIcon.addTarget(self, action: #selector(deleteSubview(_:)), for: .touchUpInside)
//        deleteIcon.tag = 999
//    }
//    
//    func setDeleteIconsHidden(_ hidden: Bool) {
//        // 假设deleteIcon是每个subview的子视图的标签
//        for subview in contentView.subviews {
//            // 根据您如何添加deleteIcon，找到并设置其isHidden属性
//            // 这里是一个简化的示例，您的实现可能会有所不同
//            if let deleteIcon = subview.subviews.first(where: { $0.tag == 999 }) { // 假设您给deleteIcon设置了特定的tag
//                deleteIcon.isHidden = hidden
//            }
//        }
//    }
//
//
//    @objc func deleteSubview(_ sender: UIButton) {
//        if let imageView = sender.superview as? PaidImageView, imageView.isPaid {
//                paidImageCount -= 1
//            }
//        print(paidImageCount)
//
//        sender.superview?.removeFromSuperview()
//    }
//    
//    @objc func backButtonTapped() {
//        // 返回上一个视图控制器
//        navigationController?.popViewController(animated: true)
//        navigationController?.tabBarController?.tabBar.isHidden = false
//    }
//    
//    func addContentToContentView(_ content: Any, matchContentViewSize: Bool) {
//        if let image = content as? UIImage {
//            // 处理 UIImage 类型的内容
//            let selectedImageView = PaidImageView(image: image) // 使用 PaidImageView
//            setupImageView(selectedImageView, matchContentViewSize: matchContentViewSize)
//        } else if let submitText = content as? CCSubmitText {
//            // 处理 CCSubmitText 类型的内容
//            let label = UILabel()
//            setupLabel(label, with: submitText)
//        } else if let imageView = content as? PaidImageView {
//            // 如果直接传入了 PaidImageView 类型的实例
//            setupImageView(imageView, matchContentViewSize: matchContentViewSize)
//        } else {
//            // 如果传入的是其他不支持的类型
//            print("Unsupported content type")
//        }
//    }
//
//    func setupImageView(_ imageView: PaidImageView, matchContentViewSize: Bool) {
//        contentView.addSubview(imageView)
//        // 检查是否为新添加的视图
//        if imageView.superview?.subviews != nil {
//            // 这里添加布局和配置imageView的代码
//            if matchContentViewSize {
//                imageView.layout { view in
//                    view.height == contentView.height
//                    view.width == contentView.width
//                }
//            }
//            imageView.layout { view in
//                // 仅为新图片设置中心约束
//                view.centerX == view.superview.centerX
//                view.centerY == view.superview.centerY
//            }
//        }
//
//        // 通用配置，为imageView添加手势和icon
//        if !matchContentViewSize {
//            addGestures(to: imageView)
//            addIconsTo(view: imageView)
//        }
//    }
//
//    func setupLabel(_ label: UILabel, with submitText: CCSubmitText) {
//        label.text = submitText.text
//        label.font = submitText.font
//        label.textColor = submitText.color
//        contentView.addSubview(label)
//        // 这里添加布局和配置label的代码
//        // 根据matchContentViewSize标志来设置label布局
//        label.layout { view in
//            view.height == 50
////            view.width == 200
//            view.centerX == contentView.centerX
//            view.centerY == contentView.centerY
//        }
////        label.widthAnchor.constraint(lessThanOrEqualToConstant: view.bounds.width - 40).isActive = true
//
//        // 设置label的最大宽度（可选），防止文本过长时超出屏幕
//        label.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.bounds.width).isActive = true
//
//        label.numberOfLines = 0 // 允许多行显示
//        addGestures(to: label)
//        addIconsTo(view: label)
//    }
//    func setBackgroundView(_ image: UIImage?){
//        guard let background = image else { return }
//        
//        let backgroundViewTag = 999 // 假设我们给背景视图的tag设置为999
//        if let oldBackgroundView = contentView.viewWithTag(backgroundViewTag) {
//            oldBackgroundView.removeFromSuperview()
//        }
//        
//        let backgroundView = UIImageView(image: background)
//        backgroundView.tag = backgroundViewTag // 设置新背景视图的tag
//        backgroundView.image = image
//        backgroundView.contentMode = .scaleAspectFill // 或者选择其他适合的contentMode
//        backgroundView.clipsToBounds = true
//        contentView.addSubview(backgroundView)
//        contentView.sendSubviewToBack(backgroundView) // 确保背景视图位于最底层
//        backgroundView.layout { view in
//            view.leading == contentView.leading
//            view.trailing == contentView.trailing
//            view.top == contentView.top
//            view.bottom == contentView.bottom
//        }
//    }
//    func showFirstTimeAlertIfNeeded() {
//        let hasShownAlertKey = "hasShownFeatureAlert\(category.rawValue)"
//            let hasShownAlert = UserDefaults.standard.bool(forKey: hasShownAlertKey)
//            
//            if !hasShownAlert {
//                // 弹出提示消息
//                let alert = UIAlertController(title: "Feature Introduction", message: "This is a feature that allows you to edit cartoon patterns, you can choose different avatars, bodies, background patterns and various stickers which can be moved to any position and scaled in size.\n\nIf you select a paid clip for editing, you need to consume the corresponding number of coins when saving.\n\n*Selected clips with multiple avatars, bodies and stickers may be stacked on top of each other, you can drag them to separate them.", preferredStyle: .alert)
//                let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
//                    UserDefaults.standard.set(true, forKey: hasShownAlertKey)
//                }
//                alert.addAction(yesAction)
//                present(alert, animated: true)
//            }
//        }
//    func alertForPaidSave(message: String){
//        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: "Yes", style: .default))
//           // 如果你在UIViewController中
//           present(alert, animated: true)
//           // 如果不在UIViewController中，需要获取当前的UIViewController来展示Alert
//    }
//}
//extension CollageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    // 显示图片选择器
//    func showImagePicker() {
//        let status = PHPhotoLibrary.authorizationStatus()
//        if status == .notDetermined {
//            PHPhotoLibrary.requestAuthorization { status in
//                if status == .authorized {
//                    self.presentPicker()
//                }
//            }
//        } else if status == .authorized {
//            self.presentPicker()
//        } else {
//            // 处理未获得权限的情况
//        }
//    }
//    
//    func presentPicker() {
//        DispatchQueue.main.async {
//            let picker = UIImagePickerController()
//            picker.sourceType = .photoLibrary
//            picker.delegate = self
//            self.present(picker, animated: true, completion: nil)
//        }
//    }
//    
//    
//    // 实现UIImagePickerControllerDelegate方法
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        
//        if let image = info[.originalImage] as? UIImage {
//            // 使用选取的图片作为背景
//            setBackgroundView(image)
//            
//            // 如果您还想将图片保存到相册，可以保留下面的代码
////            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//        }
//    }
//    
//    func renderContentViewToImage(_ contentView: UIView) -> UIImage? {
//        let renderer = UIGraphicsImageRenderer(bounds: contentView.bounds)
//        return renderer.image { context in
//            contentView.layer.render(in: context.cgContext)
//        }
//    }
//
//
//    // 保存图片后的回调方法
//    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if let error = error {
//            // 保存失败
//            self.view.makeToast("Error Save",duration: 1.0,position: .center)
//
//            print("Error Saving: \(error.localizedDescription)")
//        } else {
//            // 保存成功
//            self.view.makeToast("Image Saved Successfully",duration: 1.0,position: .center)
//
//            print("Image Saved Successfully")
//        }
//    }
//    
//    func saveContentViewToImage(contentView: UIView) {
//        
//        // 隐藏deleteIcon
//        setDeleteIconsHidden(true)
//
//        // 开始图形上下文
//        UIGraphicsBeginImageContextWithOptions(contentView.bounds.size, false, UIScreen.main.scale)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        
//        // 将contentView的层渲染到上下文
//        contentView.layer.render(in: context)
//        guard let capturedImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
//        
//        // 结束图形上下文
//        UIGraphicsEndImageContext()
//        
//        // 显示deleteIcon
//        setDeleteIconsHidden(false)
//        //        let capturedImage = image
//        // 保存图片到相册
//        // 检查相册访问权限
//        PHPhotoLibrary.requestAuthorization { status in
//            DispatchQueue.main.async {
//                switch status {
//                case .authorized:
//                    // 有权限，保存图片到相册
//                    UIImageWriteToSavedPhotosAlbum(capturedImage, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
//                case .denied, .restricted, .limited:
//                    // 无权限
//                    self.view.makeToast("Photo library access denied or restricted.", title: "Save failed")
//
//                    print("Photo library access denied or restricted.")
//                default:
//                    // 未决定，一般不会执行到这里
//                    break
//                }
//            }
//        }
////        UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
//        //               guard isNeedToSaveSandBox else {return}
//        // 生成唯一文件名
//        let fileName = "capturedImage_\(Date().timeIntervalSince1970).png"
//        if let data = capturedImage.pngData() {
//            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let filePath = documentsDirectory.appendingPathComponent(fileName)
//            
//            do {
//                // 写入数据到沙盒路径
//                try data.write(to: filePath)
//                print("Saved image to: \(filePath)")
//            } catch {
//                print("Could not save image: \(error)")
//            }
//        }
//    }
//
//
//}
//class PaidImageView: UIImageView {
//    var isPaid: Bool = false
//}
//extension CollageViewController:UITextFieldDelegate {
//    
//    // 点击屏幕收起键盘
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        view.endEditing(true)
//        
//    }
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            // 这里假设您已经有一个叫 editAndControlViewBottomConstraint 的底部约束的IBOutlet
//            editAndControlViewBottomConstraint!.constant = -keyboardHeight // 将EditAndControlView上移
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        editAndControlViewBottomConstraint!.constant = 0 // 恢复原始位置
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }
//
//}
