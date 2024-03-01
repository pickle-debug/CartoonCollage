//
//  CollageCollectionViewCell.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/1.
//

import UIKit

import UIKit

class CollageCollectionViewCell: UICollectionViewCell {
        
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // 根据需要设置图片的内容模式
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var image: UIImage? {
         didSet {
             imageView.image = image
         }
     }
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupImageView()
     }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        imageView.layer.cornerRadius = 23
        imageView.layout { view in
            view.height == 166
            view.width == 166
            view.centerX == contentView.centerX
            view.centerY == contentView.centerY
        }
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
