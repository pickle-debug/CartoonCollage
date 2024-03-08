//
//  CCTextEditView.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/4.
//

import Foundation
import UIKit
import Photos

protocol CCBackgroundEditViewDelegate: AnyObject {
    func ccBackgroundEditViewDidRequestImagePicker(_ view: CCBackgroundEditView)
}


class CCBackgroundEditView: UIView {
//    func didFinishPickingImage(_ image: UIImage) {
//        <#code#>
//    }
//    
//    func didFailPickingImage() {
//        <#code#>
//    }
    
    var selectedBackground: ((UIImage?) -> Void)?
    
    weak var delegate: CCBackgroundEditViewDelegate?
//    let imagePickerManager = CCImagePickerManager()

   
    
    let BackgroundImages: [UIImage] = (1...8).compactMap { UIImage(named: "Background\($0)") }
    
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let scrollView = UIScrollView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        imagePickerManager.delegate = self
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        
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
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
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
    @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view, let index = scrollView.subviews.firstIndex(of: tappedView) else { return }
        
        // 使用index从gradientImages数组中获取对应的UIImage
        let selectedGradientImage = gradientImages[index]
        
        // 通过闭包传出选中的渐变色UIImage
        selectedBackground?(selectedGradientImage)
        
        // 判断当前view是否已经放大
        let isExpanded = tappedView.transform != .identity
        
        // 缩小所有views，除了当前点击的view
        scrollView.subviews.forEach { view in
            if view !== tappedView {
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0,
                               options: [],
                               animations: {
                    view.transform = .identity
                })
            }
        }
        
        // 如果当前view没有放大，或者需要应用弹性动画，则放大之
        if !isExpanded {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                tappedView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        } else {
            // 如果已经放大，仅应用弹性效果
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                // 重新应用放大transform来触发弹性动画，但实际上大小不变
                tappedView.transform = tappedView.transform.scaledBy(x: 1.001, y: 1.001)
            }) { _ in
                // 动画完成后恢复到原本的放大状态
                UIView.animate(withDuration: 0.3,
                               animations: {
                    tappedView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                })
            }
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
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.layout { view in
                view.width == 40
                view.height == 40
            }
            cell.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        } else {
            cell.image = BackgroundImages[indexPath.item - 1]
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.layout { view in
                view.width == 166
                view.height == 166
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            delegate?.ccBackgroundEditViewDidRequestImagePicker(self)
        } else {
            let selectedImage = BackgroundImages[indexPath.item - 1]
            selectedBackground?(selectedImage)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
