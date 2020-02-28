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
        prepareTF(TF: serviceLastName, placeholder: "姓")
        prepareTF(TF: serviceFirstName, placeholder: "名前")
        
        //アプリ利用者側のTFの配置
        prepareTF(TF: appLastName, placeholder: "姓")
        prepareTF(TF: appFirstName, placeholder: "名前")

        //ボタンの角丸
        nextBtn.layer.cornerRadius = 6
        
    }
    
    override func viewDidLayoutSubviews() {
//        let NavH:CGFloat? = navigationController?.navigationBar.frame.size.height
//        let topM:CGFloat? = self.view.safeAreaInsets.top
        let labelcgS:CGFloat? = self.serviceLabel.frame.origin.y
        let labelcgA:CGFloat? = self.appLabel.frame.origin.y
        
        setTF(TF: serviceLastName, x: 32, y: labelcgS! + 40)
        setTF(TF: serviceFirstName, x: 48 + (UIScreen.main.bounds.size.width - 80) / 2, y: labelcgS! + 40)
        setTF(TF: appLastName, x: 32, y: labelcgA! + 40)
        setTF(TF: appFirstName, x: 48 + (UIScreen.main.bounds.size.width - 80) / 2, y: labelcgA! + 40)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //TFの準備
    func prepareTF(TF: UITextField, placeholder: String){
        TF.placeholder = placeholder
        TF.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        TF.layer.cornerRadius = 6.0
        self.view.addSubview(TF)
    }
    
    //TFの配置
    func setTF(TF: UITextField, x: CGFloat, y: CGFloat){
        TF.frame = CGRect(x: x, y: y, width: (UIScreen.main.bounds.size.width - 80) / 2 , height: 48)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    
    @IBAction func nextVC(_ sender: Any) {
        if serviceLastName.text!.isEmpty == false && serviceFirstName.text!.isEmpty == false && appLastName.text!.isEmpty == false && appFirstName.text!.isEmpty == false{
            let vc = SignUp2ViewController()
            let lastVC = SignUp8ViewController()
            lastVC.userInfo.sName = serviceLastName.text! + " " + serviceFirstName.text!
            lastVC.userInfo.aName = appLastName.text! + " " + appLastName.text!
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }else{
            showErrorAlert(text: "空白箇所があります")
        }
        
        
        
    }
}
