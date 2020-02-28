//
//  SignUp8ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp7ViewController: UIViewController {
    
    let emergencyNum: CustomTextField! = CustomTextField()
    @IBOutlet weak var emergencyLable: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBarのタイトル設定
        self.title = "アプリ利用者情報"
        
        //TFの設定
        emergencyNum.placeholder = "緊急連絡先(電話番号)"
        emergencyNum.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        emergencyNum.layer.cornerRadius = 6
        self.view.addSubview(emergencyNum)
        
        nextBtn.layer.cornerRadius = 6.0
        
    }
    
    override func viewDidLayoutSubviews() {
        let labelLoc:CGFloat? = emergencyLable.frame.origin.y
        print(labelLoc!)
        self.emergencyNum.frame = CGRect(x: 32, y: labelLoc! + 40, width: UIScreen.main.bounds.size.width - 64, height: 48)
    }
    
    @IBAction func tapToNext(_ sender: Any) {
        if emergencyNum.text != nil{
            let vc = SignUp8ViewController()
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }
    }



}
