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
    var bottomM:CGFloat? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //ボタンの角調整
        signUpBtn.layer.cornerRadius = 24.0
        loginBtn.layer.cornerRadius = 24.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //safeAreaのbottomのheightを取得
        bottomM = self.view.safeAreaInsets.bottom
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationbarを非表示にする
        navigationController?.navigationBar.isHidden = true
        
        
    }
    
    //初回利用タップ時→新規登録画面に遷移
    @IBAction func tapSignUp(_ sender: Any) {
        let vc = SignUp0ViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //ログインタップ時→ログイン画面に遷移
    @IBAction func tapLogin(_ sender: Any) {
        let vc = LoginViewController()
        vc.bottomMargin = bottomM
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }

}

