//
//  CCTextEditView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/4.
//

import Foundation
import UIKit

class CCBackgroundEditView: UIView {
    var selectedBackground: ((UIImage?) -> Void)?

    // 创建渐变色UIImage
    let gradientImages: [UIImage?] = [
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FED267"), UIColor.init(hexString: "#F5B44A")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#C6A0FC"), UIColor.init(hexString: "#AA84F3")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CEFFFF"), UIColor.init(hexString: "#AEFBFC")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CED6FF"), UIColor.init(hexString: "#AECDFC")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#CEFFD9"), UIColor.init(hexString: "#AEFCBF")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FFCEF7"), UIColor.init(hexString: "#DEAEFC")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#00EBFB"), UIColor.init(hexString: "#40BCFB")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#01EF93"), UIColor.init(hexString: "#0CFACC")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#FC7C90"), UIColor.init(hexString: "#F9D361")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#AECAFA"), UIColor.init(hexString: "#7B7BFA")]),
        UIColor.gradientImage(withSize: CGSize(width: 46, height: 46), colors: [UIColor.init(hexString: "#F0F893"), UIColor.init(hexString: "#9BFDBE")])
    ]
    
    let BackgroundImages: [UIImage] = (1...8).compactMap { UIImage(named: "Background\($0)") }

    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false // 隐藏横向滚动条
        scrollView.showsVerticalScrollIndicator = false // 如果需要，也隐藏纵向滚动条
        self.addSubview(scrollView)
        
        scrollView.layout { view in
            view.height == 60  //假设scrollView填满父视图
            view.width == self.width
            view.top == self.top + 57
        }
        
        var previousView: UIView?
        var totalWidth: CGFloat = 20 // 初始左边距
        
        for image in gradientImages {
            let view = UIView()
            if let image = image {
                view.backgroundColor = UIColor(patternImage: image)
            }
            
            scrollView.addSubview(view)
            
            view.layout { view in
                view.height == 46
                view.width == 46
            }
            view.layer.cornerRadius = 23.0
            
            if let previousView = previousView {
                view.layout { view in
                    view.leading == previousView.trailing + 20
                    view.centerY == scrollView.centerY
                }
            } else {
                view.layout { view in
                    view.leading == scrollView.leading + 20
                    view.centerY == scrollView.centerY
                }
            }
            
            totalWidth += 46 + 20 // 更新总宽度（view宽度 + 间距）
            previousView = view
        }
        
        if let lastView = previousView {
            totalWidth += 20 // 添加最后一个view的右边距
            scrollView.layout { view in
                view.trailing == lastView.trailing + 20
            }
        }
        
        // 设置scrollView的contentSize
        scrollView.contentSize = CGSize(width: totalWidth, height: self.frame.height)
        
        setupCollectionView()
        self.addSubview(collectionView)
        collectionView.layout { view in
            view.height == self.height
            view.width == self.width
            view.top == scrollView.bottom + 19
            view.centerX == self.centerX
        }
    }
    func setupCollectionView(){
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
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 57, right: 16) // 设置内容区域的内边距
        }
    }

}
extension CCBackgroundEditView: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  BackgroundImages.count// 第三个选项有10个项目
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollageCollectionViewCell", for: indexPath) as! CollageCollectionViewCell
        cell.layer.cornerRadius = 23
        cell.layer.masksToBounds = true
        if indexPath.item == 0 {
            cell.image = UIImage(named: "addPic")?.withRenderingMode(.alwaysOriginal)
            cell.imageView.layout { view in
                view.width == 40
                view.height == 40
            }
            cell.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        } else {
            cell.image = BackgroundImages[indexPath.item - 1]
            cell.imageView.layout { view in
                view.width == 166
                view.height == 166
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedImage: UIImage?
        
        selectedBackground?(selectedImage)
    } 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
