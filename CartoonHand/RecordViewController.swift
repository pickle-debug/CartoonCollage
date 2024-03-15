//
//  RecordViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

struct loaclSandBoxImage {
    var image: UIImage
    var filename: String
}


class RecordViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    let empty = UIImageView()
    
    let emptyTip = UILabel()
    
    var loaclSandBoxImages: [loaclSandBoxImage] = []

//    var layout = UICollectionViewFlowLayout()
//
//    var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // 你可以在这里对layout进行配置，例如设置itemSize等
        layout.itemSize = CGSize(width: 166, height: 166)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F4FFFF")

//        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")

        loadImages() // 重新加载图片数据
        print(loaclSandBoxImages.count)
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(handleImageDeletion), name: NSNotification.Name("ImageDeleted"), object: nil)


        titleLabel.text = "History"
        titleLabel.font = UIFont.systemFont(ofSize: 24,weight: .heavy)
        titleLabel.textColor = .black

        self.navigationItem.titleView = titleLabel
        
        loadImages()
        if loaclSandBoxImages.isEmpty {
            setEmptyUI()
        } else {
            setupUI()
        }

    }
    func loadImages() {
        loaclSandBoxImages.removeAll() // 清空数组

        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: documentsPath)
            for filePath in filePaths {
                let fullPath = (documentsPath as NSString).appendingPathComponent(filePath)
                if let image = UIImage(contentsOfFile: fullPath) {
                    let loaclSandBoxImage = loaclSandBoxImage(image: image, filename: filePath) // 注意这里filePath就是文件名
                    loaclSandBoxImages.append(loaclSandBoxImage)
                }
            }
        } catch {
            print("Could not retrieve files: \(error.localizedDescription)")
        }
    }

    func setEmptyUI(){
        
        
        self.view.addSubview(empty)
        empty.image = UIImage(named: "EmptyHistory")
        empty.layout { view in
            view.height == 257.23
            view.width == 242
            view.top == view.superview.top + 173
            view.centerX == view.superview.centerX
        }
        self.view.addSubview(emptyTip)
        emptyTip.text = "No data, go edit some content"
        emptyTip.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        emptyTip.textColor = UIColor.init(hexString: "#B1B6C2")
        emptyTip.layout { view in
            view.height == 17
            view.width == 208
            view.top == empty.bottom + 70
            view.centerX == view.superview.centerX
        }
    }
    
    func setupUI() {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 166, height: 166)
//        
//        collectionView.backgroundColor = .clear
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        if collectionView.superview == nil {
               // 初始化collectionView，设置布局和代理
               self.view.addSubview(collectionView)
           }
        collectionView.layout { view in
            view.top == view.superview.top + kNavBarFullHeight
            view.bottom == view.superview.bottom - kTabBarHeight
            view.width == 343
            view.centerX == view.superview.centerX
        }
    }
    func updateUI() {
        // 移除所有可能添加的UI元素，例如EmptyUI视图或其他视图
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        
        // 根据当前数据重新设置UI
        if loaclSandBoxImages.isEmpty {
            setEmptyUI()
        } else {
            setupUI()
            collectionView.reloadData()
        }
    }

}
extension RecordViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(loaclSandBoxImages.count)
           return loaclSandBoxImages.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           let imageView = UIImageView(image: loaclSandBoxImages[indexPath.row].image)
           imageView.frame = CGRect(x: 0, y: 0, width: 167, height: 167)
           cell.contentView.addSubview(imageView)
           return cell
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap")
        let nextViewController = CCRecordDetailViewController(image: loaclSandBoxImages[indexPath.row])
        nextViewController.view.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        navigationController?.tabBarController?.tabBar.isHidden = true

        // 推入下一个视图控制器
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 根据需要返回单元格的大小
        return CGSize(width: 166, height: 166)
    }
}
