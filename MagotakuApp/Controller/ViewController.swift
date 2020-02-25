//
//  ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンの角調整
        signUpBtn.layer.cornerRadius = 24.0
        loginBtn.layer.cornerRadius = 24.0
        
    }
    
    //初回利用タップ時→新規登録画面に遷移
    @IBAction func tapSignUp(_ sender: Any) {
        
    }
    
    //ログインタップ時→ログイン画面に遷移
    @IBAction func tapLogin(_ sender: Any) {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    


}

