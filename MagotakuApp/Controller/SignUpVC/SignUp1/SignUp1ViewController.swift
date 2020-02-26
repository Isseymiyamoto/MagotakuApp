//
//  SignUp1ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    //サービス利用者
    let serviceLastName: CustomTextField! = CustomTextField()
    let serviceFirstName: CustomTextField! = CustomTextField()
    //アプリ利用者
    let appLastName: CustomTextField! = CustomTextField()
    let appFirstName: CustomTextField! = CustomTextField()
    
    
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "利用者情報"
        
        self.serviceLastName.delegate = self
        self.serviceLastName.delegate = self
        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 35/255, blue: 57/255, alpha: 1)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        
        //TFの配置
//        self.serviceLastName.frame = CGRect(x: 32, y: 192 , width: (UIScreen.main.bounds.size.width - 80) / 2 , height: 48)
//        self.serviceFirstName.frame = CGRect(x: 48 + (UIScreen.main.bounds.size.width - 80) / 2 , y: 192 , width: (UIScreen.main.bounds.size.width - 80) / 2, height: 48)
        self.serviceLastName.placeholder = "姓"
        self.serviceFirstName.placeholder = "名前"
        self.serviceLastName.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        self.serviceFirstName.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        self.serviceLastName.layer.cornerRadius = 6
        self.serviceFirstName.layer.cornerRadius = 6
        self.view.addSubview(self.serviceFirstName)
        self.view.addSubview(self.serviceLastName)
        
        nextBtn.layer.cornerRadius = 24.0
        
    }
    
    override func viewDidLayoutSubviews() {
        let NavH:CGFloat? = navigationController?.navigationBar.frame.size.height
        let topM:CGFloat? = self.view.safeAreaInsets.top
        print(NavH!)
        print(topM!)
        
        self.serviceLastName.frame = CGRect(x: 32, y: 72 + topM! + NavH! , width: (UIScreen.main.bounds.size.width - 80) / 2 , height: 48)
        self.serviceFirstName.frame = CGRect(x: 48 + (UIScreen.main.bounds.size.width - 80) / 2 , y: 72 + topM! + NavH! , width: (UIScreen.main.bounds.size.width - 80) / 2, height: 48)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
