//
//  SignUp1ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var appLabel: UILabel!
    
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
        self.serviceFirstName.delegate = self
        self.appLastName.delegate = self
        self.appFirstName.delegate = self
        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 35/255, blue: 57/255, alpha: 1)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
                
        //サービス利用者側のTFの配置
        self.serviceLastName.placeholder = "姓"
        self.serviceFirstName.placeholder = "名前"
        self.serviceLastName.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        self.serviceFirstName.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        self.serviceLastName.layer.cornerRadius = 6
        self.serviceFirstName.layer.cornerRadius = 6
        self.view.addSubview(self.serviceFirstName)
        self.view.addSubview(self.serviceLastName)
        
        //アプリ利用者側のTFの配置
        self.appLastName.placeholder = "姓"
        self.appFirstName.placeholder = "名前"
        self.appLastName.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        self.appFirstName.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        self.appLastName.layer.cornerRadius = 6
        self.appFirstName.layer.cornerRadius = 6
        self.view.addSubview(self.appFirstName)
        self.view.addSubview(self.appLastName)
        //ボタンの角丸
        nextBtn.layer.cornerRadius = 6
        
    }
    
    override func viewDidLayoutSubviews() {
//        let NavH:CGFloat? = navigationController?.navigationBar.frame.size.height
//        let topM:CGFloat? = self.view.safeAreaInsets.top
        let labelcgS:CGFloat? = self.serviceLabel.frame.origin.y
        let labelcgA:CGFloat? = self.appLabel.frame.origin.y
        
        self.serviceLastName.frame = CGRect(x: 32, y: labelcgS! + 40  , width: (UIScreen.main.bounds.size.width - 80) / 2 , height: 48)
        self.serviceFirstName.frame = CGRect(x: 48 + (UIScreen.main.bounds.size.width - 80) / 2 , y: labelcgS! + 40 , width: (UIScreen.main.bounds.size.width - 80) / 2, height: 48)
        self.appLastName.frame = CGRect(x: 32, y: labelcgA! + 40  , width: (UIScreen.main.bounds.size.width - 80) / 2 , height: 48)
        self.appFirstName.frame = CGRect(x: 48 + (UIScreen.main.bounds.size.width - 80) / 2 , y: labelcgA! + 40 , width: (UIScreen.main.bounds.size.width - 80) / 2, height: 48)
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

    
    
    
    @IBAction func nextVC(_ sender: Any) {
        let vc = SignUp2ViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
