//
//  CCImageSelectView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/6.
//

import UIKit

class CCImageSelectView: UIView {

    var selectedPic: ((UIImage?) -> Void)?

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let images: [UIImage]
    
    init(frame: CGRect,images: [UIImage]) {
        self.images = images
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
            flowLayout.sectionInset = UIEdgeInsets(top: 57, left: 16, bottom: 10, right: 16) // 设置内容区域的内边距
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
            return  images.count// 第三个选项有10个项目
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        selectedPic?(selectedImage)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
