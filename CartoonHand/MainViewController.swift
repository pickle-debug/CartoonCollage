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
        //MARK: - 顶部装饰性tip
        self.view.addSubview(tipBackGround)
        tipBackGround.image = UIImage(named: "Group 44")
        tipBackGround.layout { view in
            view.height == 297.87
            view.width == 376
            view.trailing == view.superview.trailing
            view.top == view.superview.top + 60
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
        
        self.view.addSubview(realInter)
        realInter.setImage(UIImage(named: "Group 46"), for: .normal)
        realInter.addTarget(self, action: #selector(toRealHeadCollage), for: .touchUpInside)
        realInter.translatesAutoresizingMaskIntoConstraints = false
        realInter.layout { view in
            view.height == 339
            view.width == 362
            view.trailing == tip.trailing
            view.top == tip.bottom + 18
        }

        self.view.addSubview(cartoonInter)
        cartoonInter.setImage(UIImage(named: "Group 45"), for: .normal)
        cartoonInter.addTarget(self, action: #selector(toCartoonHeadCollage), for: .touchUpInside)
        cartoonInter.translatesAutoresizingMaskIntoConstraints = false
        
        cartoonInter.layout { view in
            view.height == 302.98
            view.width == 185
            view.leading == tip.leading
            view.top == tip.bottom + 48
        }
    
    }

    @objc func toRealHeadCollage(){
        // 创建下一个视图控制器
        let nextViewController = CollageViewController(images: RealHeadImages)
//        nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.view.backgroundColor = UIColor.init(hexString: "#E5FDFF")
        navigationController?.tabBarController?.tabBar.isHidden = true

        // 推入下一个视图控制器
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    @objc func toCartoonHeadCollage(){
        let nextViewController = CollageViewController(images: HeadImages)
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
