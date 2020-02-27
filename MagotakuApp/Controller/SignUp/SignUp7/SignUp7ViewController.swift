//
//  SignUp1ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp7ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    //メールアドレスTF
    let mailTF: CustomTextField! = CustomTextField()
    //パスワードTF
    let passwordTF: CustomTextField! = CustomTextField()
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "アプリ利用者情報"
        
        self.mailTF.delegate = self
        self.passwordTF.delegate = self
        
        //TFの角丸メソッド
        prepareTF(TF: mailTF, placeholder: "メールアドレス")
        prepareTF(TF: passwordTF, placeholder: "パスワード")

        //ボタンの角丸
        nextBtn.layer.cornerRadius = 6
        
    }
    
    override func viewDidLayoutSubviews() {
//        let NavH:CGFloat? = navigationController?.navigationBar.frame.size.height
//        let topM:CGFloat? = self.view.safeAreaInsets.top
        let labelcgS:CGFloat? = self.mailLabel.frame.origin.y
        let labelcgA:CGFloat? = self.passwordLabel.frame.origin.y
        
        setTF(TF: mailTF, x: 32, y: labelcgS! + 40)
        setTF(TF: passwordTF, x: 32, y: labelcgA! + 40)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = false
//    }
    
    //TFの準備
    func prepareTF(TF: UITextField, placeholder: String){
        TF.placeholder = placeholder
        TF.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        TF.layer.cornerRadius = 6.0
        self.view.addSubview(TF)
    }
    
    //TFの配置
    func setTF(TF: UITextField, x: CGFloat, y: CGFloat){
        TF.frame = CGRect(x: x, y: y, width: UIScreen.main.bounds.size.width - 64 , height: 48)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    
    @IBAction func nextVC(_ sender: Any) {
        let vc = SignUp8ViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
