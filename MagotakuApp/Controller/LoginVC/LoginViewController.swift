//
//  LoginViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let mailTF: CustomTextField! = CustomTextField()
    let passwordTF: CustomTextField! = CustomTextField()
    let loginBtn: UIButton! = UIButton(frame: CGRect(x: 32, y: UIScreen.main.bounds.size.height - 188, width: UIScreen.main.bounds.size.width - 64, height: 48))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LoginBtnの配置
        self.loginBtn.backgroundColor = UIColor(red: 124/255, green: 143/255, blue: 230/255, alpha: 1)
        self.loginBtn.layer.cornerRadius = 24.0
        self.loginBtn.setTitle("ログイン", for: .normal)
        self.loginBtn.addTarget(self, action: #selector(pushLoginBtn), for: .touchUpInside)
        self.view.addSubview(self.loginBtn)
        
        //TFの配置
        self.mailTF.frame = CGRect(x: 32, y: UIScreen.main.bounds.size.height - 318, width: UIScreen.main.bounds.size.width - 64, height: 48)
        self.passwordTF.frame = CGRect(x: 32, y: UIScreen.main.bounds.size.height - 268, width: UIScreen.main.bounds.size.width - 64, height: 48)
        self.mailTF.placeholder = "メールアドレス"
        self.passwordTF.placeholder = "パスワード"
        self.mailTF.backgroundColor = UIColor.white
        self.passwordTF.backgroundColor = UIColor.white
        self.view.addSubview(self.mailTF)
        self.view.addSubview(self.passwordTF)
        
        //TF、指定箇所のみCornerRadius適用
        partCornerRadius(TF: mailTF, corner1: .layerMinXMinYCorner, corner2: .layerMaxXMinYCorner)
        partCornerRadius(TF: passwordTF, corner1: .layerMinXMaxYCorner, corner2: .layerMaxXMaxYCorner)
        
    }
    
    
    //引数、指定箇所のみ角丸にするメソッド
    func partCornerRadius(TF: UITextField, corner1: CACornerMask, corner2: CACornerMask){
        TF.borderStyle = .none
        TF.layer.cornerRadius = TF.frame.height / 4
        TF.layer.maskedCorners = [corner1, corner2]
        TF.layer.borderColor = UIColor.lightGray.cgColor
        TF.layer.masksToBounds = true
    }
    
    
    @IBAction func backToFVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pushLoginBtn(sender: UIButton){
        print("LoginBtnが押されました")
    }
    
    
   

}
