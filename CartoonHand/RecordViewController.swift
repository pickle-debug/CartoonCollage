//
//  RecordViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class RecordViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    let empty = UIImageView()
    
    let emptyTip = UILabel()

    var images: [UIImage] = []
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")

        let title = UILabel()
        title.text = "History"
        title.font = UIFont.systemFont(ofSize: 24,weight: .heavy)
        title.textColor = .black

        self.navigationItem.titleView = title
        
        loadImages()
        if images.isEmpty {
            setEmptyUI()
        } else {
            setupUI()
        }

    }
    func loadImages() {
            let fileManager = FileManager.default
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            
            do {
                let filePaths = try fileManager.contentsOfDirectory(atPath: documentsPath)
                for filePath in filePaths {
                    let fullPath = (documentsPath as NSString).appendingPathComponent(filePath)
                    if let image = UIImage(contentsOfFile: fullPath) {
                        images.append(image)
                    }
                }
            } catch {
                print("Could not retrieve files: \(error.localizedDescription)")
            }
        }
    
    func setEmptyUI(){
        
        self.view.addSubview(titleLabel)
        titleLabel.text = "History"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.layout { view in
            view.centerX == view.superview.centerX
            view.top == view.superview.top + 60
        }
        
        self.view.addSubview(empty)
        empty.image = UIImage(named: "EmptyHistory")
        empty.layout { view in
            view.height == 257.23
            view.width == 242
            view.top == titleLabel.bottom + 98
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 166, height: 166)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        collectionView.layout { view in
            view.top == view.superview.top + 120
            view.bottom == view.superview.bottom
            view.width == 343
            view.centerX == view.superview.centerX
        }
    }
}
extension RecordViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return images.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           let imageView = UIImageView(image: images[indexPath.row])
           imageView.frame = CGRect(x: 0, y: 0, width: 167, height: 167)
           cell.contentView.addSubview(imageView)
           return cell
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap")
        let nextViewController = CCRecordDetailViewController(image: images[indexPath.row])
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
