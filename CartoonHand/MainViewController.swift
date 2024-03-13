//
//  HomePageViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class MainViewController: UIViewController {
    
    //顶部装饰性tip组件声明
    var tip = UIImageView()
    var tipBackGround = UIImageView()
    var tipCartoonAvatar = UIImageView()
    //卡通头像入口
    var cartoonInter = UIButton()
//    var CollageViewController = UIViewController()
    //真实头像入口
    var realInter = UIButton()
//    var realHeadCollageVC = UIViewController()

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        // Do any additional setup after loading the view.
    }
    func setUI(){
//        self.navigationController?.navigationBar.removeFromSuperview()
        //MARK: - 顶部装饰性tip
        self.view.addSubview(tipBackGround)
        tipBackGround.image = UIImage(named: "Group 44")?.withRenderingMode(.alwaysOriginal)
        tipBackGround.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tipBackGround.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tipBackGround.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//        ])
//        tipBackGround.layout { view in
//            view.trailing == view.superview.trailing
//            view.top == view.superview.top + 40
//        }
        tipBackGround.layout { view in
            view.trailing == view.superview.trailing
            view.top == view.superview.top + safeAreaInsets.top
        }
        self.view.addSubview(tip)
        tip.image = UIImage(named: "Group 43")
        tip.layout { view in
            view.height == 59
            view.width == 343
            view.top == tipBackGround.top + 246
            view.centerX == view.superview.centerX
        }
        self.view.addSubview(tipCartoonAvatar)
        tipCartoonAvatar.image = UIImage(named: "Group 10")
        tipCartoonAvatar.layout { view in
            view.height == 237
            view.width == 290
            view.bottom == tip.bottom - 47
            view.trailing == tipBackGround.trailing - 65
        }
        
        //MARK: - 主页真实头像与卡通头像入口的UI设置
        let buttonContendView = UIView()
        self.view.addSubview(buttonContendView)
        
        
        self.view.addSubview(realInter)
        realInter.setImage(UIImage(named: "realInter")?.withRenderingMode(.alwaysOriginal), for: .normal)
        realInter.imageView?.contentMode = .scaleAspectFit
        realInter.addTarget(self, action: #selector(toRealHeadCollage), for: .touchUpInside)
        realInter.translatesAutoresizingMaskIntoConstraints = false
        realInter.layout { view in
            view.leading == tip.leading
            view.trailing == tip.trailing
            view.bottom == view.superview.bottom - (kTabBarHeight + 10)
            view.top == tip.bottom + 12
        }

        self.view.addSubview(cartoonInter)
        cartoonInter.setImage(UIImage(named: "cartoonInter")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cartoonInter.imageView?.contentMode = .scaleAspectFit
        cartoonInter.addTarget(self, action: #selector(toCartoonHeadCollage), for: .touchUpInside)
        cartoonInter.translatesAutoresizingMaskIntoConstraints = false
        
        cartoonInter.layout { view in
            view.height == realInter.height * 0.9
            view.width == realInter.width * 0.54
            view.leading == realInter.leading
            view.bottom == realInter.bottom
        }
    
    }

    @objc func toRealHeadCollage(){
        // 创建下一个视图控制器
        let category = ImageManager.ImageCategory.realHead // 选择图片类别
        let (sortedImages, paidStartIndex) = ImageManager.shared.sortedImagesWithPaidIndex(for: category)
        let nextViewController = CollageViewController(images: sortedImages,paidStartIndex: paidStartIndex,category:category)
        nextViewController.view.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        navigationController?.tabBarController?.tabBar.isHidden = true

        // 推入下一个视图控制器
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    @objc func toCartoonHeadCollage(){
        let category = ImageManager.ImageCategory.head // 选择图片类别
        let (sortedImages, paidStartIndex) = ImageManager.shared.sortedImagesWithPaidIndex(for: category)
        let nextViewController = CollageViewController(images: sortedImages,paidStartIndex: paidStartIndex,category:category)
        nextViewController.view.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        navigationController?.tabBarController?.tabBar.isHidden = true

        // 推入下一个视图控制器
        navigationController?.pushViewController(nextViewController, animated: true)
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
