//
//  CCImageSelectView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/6.
//

import UIKit

class CCImageSelectView: UIView {

    var selectedPic: ((CCSelectedPic?) -> Void)?
        
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let images: [UIImage]
    var paidStartIndex: Int?
    
    init(frame: CGRect,images: [UIImage],paidStartIndex:Int?) {
        self.images = images
        self.paidStartIndex = paidStartIndex
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 60
        self.layer.masksToBounds = true
        // 添加 UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollageCollectionViewCell.self, forCellWithReuseIdentifier: "CollageCollectionViewCell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: 166, height: 166) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 11 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 16 // 设置行之间的最小间距
            flowLayout.sectionInset = UIEdgeInsets(top: 57, left: 16, bottom: 100, right: 16) // 设置内容区域的内边距
        }
        self.addSubview(collectionView)
        collectionView.layout { view in
            view.height == self.height
            view.width == self.width
            view.centerX == self.centerX
            view.centerY == self.centerY
        }
    }
}

extension CCImageSelectView: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollageCollectionViewCell", for: indexPath) as! CollageCollectionViewCell
        cell.layer.cornerRadius = 23
        cell.layer.masksToBounds = true
        cell.image = images[indexPath.item]
        cell.imageView.layout { view in
            view.width == 166
            view.height == 166
        }
        // 先移除可能之前添加过的遮罩视图，以避免重复添加
        cell.imageView.subviews.forEach { if $0.tag == 101 { $0.removeFromSuperview() } }
        
        // 检查是否需要在图片上添加灰色遮罩
        if let paidStartIndex = paidStartIndex, indexPath.item >= paidStartIndex {
            let paidView = UIImageView()
            paidView.image = UIImage(named: "paidIcon")
            paidView.tintColor = .yellow
            paidView.tag = 101 // 设置tag以便识别和移除
            paidView.isUserInteractionEnabled = false // 不阻止用户交互
            cell.imageView.addSubview(paidView)
            
            paidView.layout { view in
                view.width == 25
                view.height == 25
                view.bottom == cell.imageView.bottom - 5
                view.trailing == cell.imageView.trailing - 5
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        let isPaid = paidStartIndex != nil && indexPath.item >= paidStartIndex!
        let selected = CCSelectedPic(image: selectedImage, isPaid: isPaid)
        selectedPic?(selected)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
struct CCSelectedPic {
    let image: UIImage
    let isPaid: Bool
    
    init(image: UIImage, isPaid: Bool) {
        self.image = image
        self.isPaid = isPaid
    }
}
