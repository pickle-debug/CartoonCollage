//
//  RealHeadCollageViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class RealHeadCollageViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        setUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")
    }
    
    @objc func backButtonTapped() {
        // 返回上一个视图控制器
        navigationController?.popViewController(animated: true)
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
