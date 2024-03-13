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
    override func prepareForReuse() {
          super.prepareForReuse()
        imageView.frame.size = CGSize(width: 166, height: 166)
          // 重置imageView的布局约束
//          imageView.layout { view in
//              view.width == 166  // 设定为默认尺寸
//              view.height == 166 // 设定为默认尺寸
//              view.centerX == contentView.centerX
//              view.centerY == contentView.centerY
//          }
//          // 移除所有可能的自定义子视图或遮罩
//          imageView.subviews.forEach { if $0.tag == 101 { $0.removeFromSuperview() } }
      }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        imageView.layer.cornerRadius = 23
        imageView.frame.size = CGSize(width: 166, height: 166)
        imageView.layout { view in
            view.centerX == contentView.centerX
            view.centerY == contentView.centerY
        }
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
