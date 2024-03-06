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

    override func viewDidAppear(_ animated: Bool) {
//        loadImagesFromDocumentsDirectory()
//
//        setUI()
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")

        loadImages()
        if images.isEmpty {
            setEmptyUI()
        } else {
            setupUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        collectionView.layout { view in
            view.top == view.superview.top + 120
            view.width == 343
            view.centerX == view.superview.centerX
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
}
