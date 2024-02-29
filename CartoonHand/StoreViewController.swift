//
//  StoreViewController.swift
//  CartoonHand
//
//  Created by Tanshuo on 2024/2/29.
//

import UIKit

class StoreViewController: UIViewController {

    let titleLabel = UILabel()

    override func viewDidAppear(_ animated: Bool) {
        setUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        
        self.view.backgroundColor = UIColor.init(hexString: "#F4FFFF")
        
        self.view.addSubview(titleLabel)
        titleLabel.text = "Store"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.layout { view in
            view.centerX == view.superview.centerX
            view.top == view.superview.top + 60

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
