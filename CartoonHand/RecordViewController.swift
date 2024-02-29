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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
