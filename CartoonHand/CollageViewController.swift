//
//  CartoonHeadCollageViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class CollageViewController: UIViewController {
    
    let contentView = UIView()
    private var currentIndex = 0
    let stickerImages: [UIImage] = (0...14).compactMap { UIImage(named: "Stickers\($0)") }
    let BodyImages: [UIImage] = (0...7).compactMap { UIImage(named: "CartoonBody\($0)") }
    let HeadImages: [UIImage] = (0...7).compactMap { UIImage(named: "CartoonHead\($0)") }
    let BackgroundImages: [UIImage] = (1...8).compactMap { UIImage(named: "Background\($0)") }
    
    let editView = UIView()
    
    private var currentTextString = ""
    
    let segmentItem = ["Body","Head","Background","Sticker","Text"]
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
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
        setUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 添加 UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 60
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollageCollectionViewCell.self, forCellWithReuseIdentifier: "CollageCollectionViewCell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: 166, height: 166) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 11 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 16 // 设置行之间的最小间距
            flowLayout.sectionInset = UIEdgeInsets(top: 57, left: 16, bottom: 10, right: 16) // 设置内容区域的内边距
        }
        //        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        
        //        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")
        
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
        case 0,1,3:
            editView.addSubview(collectionView)
            collectionView.layout { view in
                view.width == editView.width
                view.height == editView.height
                view.top == editView.top
                view.centerX == editView.centerX
            }
        case 2:
            let colorView = CCBackgroundEditView()
            editView.addSubview(colorView)
            colorView.layout { view in
                view.height == 62
                view.leading == editView.leading
                view.top == editView.top + 57
                view.centerX == editView.centerX
            }
            
            editView.addSubview(collectionView)
            collectionView.layout { view in
                view.height == editView.width
                view.height == editView.height
                view.top == colorView.bottom + 20
                view.centerX == editView.centerX
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
        default:
            0
        }
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

        // 添加缩放手势
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        view.addGestureRecognizer(pinchGesture)

        view.isUserInteractionEnabled = true
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
        guard let viewToZoom = gesture.view else { return }

        if gesture.state == .began || gesture.state == .changed {
            let scale = gesture.scale
            let currentScale = viewToZoom.frame.size.width / viewToZoom.bounds.size.width
            var newScale = currentScale * scale

            // 设置最小和最大缩放限制
            let minScale: CGFloat = 0.5
            let maxScale: CGFloat = 2.0

            newScale = min(newScale, maxScale)
            newScale = max(newScale, minScale)

            let transform = viewToZoom.transform.scaledBy(x: newScale / currentScale, y: newScale / currentScale)
            
            // 检查放大后的frame是否超出contentView的边界
            let futureFrame = viewToZoom.frame.applying(transform)
            if contentView.bounds.contains(futureFrame) {
                viewToZoom.transform = transform
            }

            gesture.scale = 1.0
        }
    }

    func addDashedBorder(to view: UIView) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.gray.cgColor
        borderLayer.lineDashPattern = [4, 2]
        borderLayer.frame = view.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(rect: view.bounds).cgPath
        view.layer.addSublayer(borderLayer)
    }
    
    func addResizeAndDeleteIcons(to view: UIView) {
        let resizeIcon = UIImageView(image: UIImage(named: "resizeIcon"))
        resizeIcon.isUserInteractionEnabled = true
        let deleteIcon = UIImageView(image: UIImage(named: "deleteIcon"))
        deleteIcon.isUserInteractionEnabled = true

        // 添加拖动手势到resizeIcon
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleResizeGesture(_:)))
        resizeIcon.addGestureRecognizer(panGesture)
        
        // 添加点击手势到deleteIcon
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDeleteTap(_:)))
        deleteIcon.addGestureRecognizer(tapGesture)

        view.addSubview(resizeIcon)
        view.addSubview(deleteIcon)

        // 配置icon位置
        resizeIcon.translatesAutoresizingMaskIntoConstraints = false
        deleteIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resizeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            resizeIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            deleteIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            deleteIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)
        ])
    }
    
    @objc func handleResizeGesture(_ gesture: UIPanGestureRecognizer) {
        guard let resizeIcon = gesture.view, let targetView = resizeIcon.superview else { return }
        if gesture.state == .changed {
            let translation = gesture.translation(in: targetView)
            let newWidth = targetView.frame.width + translation.x
            let newHeight = targetView.frame.height + translation.y
            targetView.frame.size = CGSize(width: newWidth, height: newHeight)
            gesture.setTranslation(CGPoint.zero, in: targetView)
            // 更新边框
            targetView.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() } }
            addDashedBorder(to: targetView)
        }
    }

    @objc func handleDeleteTap(_ gesture: UITapGestureRecognizer) {
        gesture.view?.superview?.removeFromSuperview()
    }




    
    @objc func backButtonTapped() {
        // 返回上一个视图控制器
        navigationController?.popViewController(animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
extension CollageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 返回与选定段相关联的项目数量
        switch control.selectedSegmentIndex {
        case 0:
            return BodyImages.count // 第一个选项有5个项目
        case 1:
            return HeadImages.count // 第二个选项有8个项目
        case 2:
            return  BackgroundImages.count// 第三个选项有10个项目
        case 3:
            return stickerImages.count // 第三个选项有10个项目
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollageCollectionViewCell", for: indexPath) as! CollageCollectionViewCell
        var image: UIImage?
        
        switch control.selectedSegmentIndex {
        case 0:
            image = BodyImages[indexPath.item] // 使用 BodyImages 数组
        case 1:
            image = HeadImages[indexPath.item] // 使用 HeadImages 数组
        case 2:
            
            image = BackgroundImages[indexPath.item] // 使用 HeadImages 数组
        case 3:
            image = stickerImages[indexPath.item] // 使用 HeadImages 数组

        default:
            break
        }
        
        cell.image = image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedImage: UIImage?

        switch control.selectedSegmentIndex {
        case 0:
            selectedImage = BodyImages[indexPath.item]
        case 1:
            selectedImage = HeadImages[indexPath.item]
        case 2:
            selectedImage = BackgroundImages[indexPath.item]
        case 3:
            selectedImage = stickerImages[indexPath.item]
        default:
            break
        }

        let selectedImageView = UIImageView()
        selectedImageView.image = selectedImage
        // 将选中的图片设置到imageView上
        contentView.addSubview(selectedImageView)
        selectedImageView.layout { view in
            view.centerX == contentView.centerX
            view.centerY == contentView.centerY
        }
        // 只为新添加的imageView添加拖动手势
        addDashedBorder(to: selectedImageView)
        addResizeAndDeleteIcons(to: selectedImageView)
        addGestures(to: selectedImageView)
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
