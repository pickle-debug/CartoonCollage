//
//  CCImageManager.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/3/12.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager()
    //区分不同的图片数组类别。
    enum ImageCategory: String {
        case sticker = "Stickers"
        case body = "CartoonBody"
        case head = "CartoonHead"
        case realHead = "RealHead"
        case background = "Background"
    }
    //存储了每个类别中需要收费的图片索引。
    private var paidImageRules: [ImageCategory: (Int) -> Bool] = [
        .sticker: { [0, 2, 5].contains($0) },//贴纸第1、3、6收费
        .body: { _ in false }, // 身体全部都为免费
        .head: { $0 >= 1 && $0 <= 6 }, // 卡通头像第2个到第7个为收费
        .realHead: { $0 != 0 }, // 真人图像仅有第一个免费
        .background: { _ in true } // 全部都为收费
    ]

    //根据传入的类别生成并返回对应的图片数组。
    func images(for category: ImageCategory) -> [UIImage] {
        let range: ClosedRange<Int>
        switch category {
        case .sticker:
            range = 0...14
        case .body:
            range = 0...7
        case .head, .realHead:
            range = 0...7
        case .background:
            range = 1...8
        }
        
        return range.compactMap { UIImage(named: "\(category.rawValue)\($0)") }
    }

    //检查指定索引的图片是否是收费的。
    func isImagePaid(at index: Int, in category: ImageCategory) -> Bool {
        return paidImageRules[category]?(index) ?? false
    }
    //对照片数组进行排序，使得收费照片沉淀到下面，并返回从哪个下标开始为收费照片
    func sortedImagesWithPaidIndex(for category: ImageCategory) -> ([UIImage], paidStartIndex: Int?) {
            let images = self.images(for: category)
            var freeImages = [UIImage]()
            var paidImages = [UIImage]()
            
            // 遍历图片，根据是否收费分配到不同的数组
            for (index, image) in images.enumerated() {
                if isImagePaid(at: index, in: category) {
                    paidImages.append(image)
                } else {
                    freeImages.append(image)
                }
            }
            
            // 合并数组，先免费后收费
            let sortedImages = freeImages + paidImages
            
            // 如果所有图片都是免费的，收费开始索引为nil
            let paidStartIndex = freeImages.isEmpty ? nil : freeImages.count
            
            return (sortedImages, paidStartIndex)
        }
}
