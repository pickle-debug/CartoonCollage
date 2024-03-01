//
//  CartoonHeadCollageViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class CollageViewController: UIViewController {
    
    let contentImage = UIImageView()
    private var currentIndex = 0
    let stickerImages: [UIImage] = (0...14).compactMap { UIImage(named: "Stickers\($0)") }
    let BodyImages: [UIImage] = (0...7).compactMap { UIImage(named: "CartoonBody\($0)") }
    let HeadImages: [UIImage] = (0...7).compactMap { UIImage(named: "CartoonHead\($0)") }
    
    
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
        control.addTarget(self, action: #selector(segementDidchange), for: .valueChanged)
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollageCollectionViewCell.self, forCellWithReuseIdentifier: "CollageCollectionViewCell")
        //        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        
        //        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")
        
        self.view.addSubview(contentImage)
        contentImage.backgroundColor = UIColor.white
        contentImage.layout { view in
            view.width == 343
            view.height == 343
            view.centerX == view.superview.centerX
            view.top == view.superview.top + 102
        }
        
        self.view.addSubview(collectionView)
        // 仅设置左上角和右上角的圆角
        //        collectionView.roundCorners(corners: [.topLeft, .topRight], radius: 60)
        //        let collectionViewHeight = CGFloat(stickerImages.count / 2) * (166 + 16) + 100
        
        collectionView.layer.cornerRadius = 60
        collectionView.layout { view in
            view.width == view.superview.width
            view.height == 300
            view.top == view.superview.bottom - 307
            view.centerX == view.superview.centerX
        }
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: 166, height: 166) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 11 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 16 // 设置行之间的最小间距
            flowLayout.sectionInset = UIEdgeInsets(top: 57, left: 16, bottom: 10, right: 16) // 设置内容区域的内边距
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
            view.centerY == collectionView.top
        }
    }
    
    @objc func segementDidchange(_ segmented: UISegmentedControl) {
        let selectedItem = segmentItem[segmented.selectedSegmentIndex]
        if let highlightedImage = UIImage(named: "\(selectedItem)_highlight") {
            segmented.setImage(highlightedImage.withRenderingMode(.alwaysOriginal), forSegmentAt: segmented.selectedSegmentIndex)
        }
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
            return 10 // 第三个选项有10个项目
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
        case 3:
            image = stickerImages[indexPath.item] // 使用 HeadImages 数组

        default:
            break
        }
        
        cell.image = image
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
