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
    @IBOutlet weak var loginBtn: UIButton!
    var bottomMargin:CGFloat? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(bottomMargin!)
        //LoginBtnの配置
        loginBtn.layer.cornerRadius = 24.0

        
        //TFの配置
        self.mailTF.frame = CGRect(x: 32, y: UIScreen.main.bounds.size.height - 318 - bottomMargin! , width: UIScreen.main.bounds.size.width - 64, height: 48)
        self.passwordTF.frame = CGRect(x: 32, y: UIScreen.main.bounds.size.height - 268 - bottomMargin! , width: UIScreen.main.bounds.size.width - 64, height: 48)
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
    
    
    @IBAction func tapLogin(_ sender: Any) {
        guard let email = mailTF.text, let password = passwordTF.text else {
            return
        }
        if email.isEmpty {
            showErrorAlert(text: "メールアドレスを入力してください🙇‍♀️")
            return
        }
        if password.isEmpty {
            showErrorAlert(text: "パスワードを入力してください🙇‍♂️")
            return
        }
        emailLogIn(email: email, password: password)
    }
    
    func emailLogIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print ("👿ログイン失敗")
                self.logInErrorAlert(error)
            } else {
                print ("🌞ログイン成功")
                //学生用のHomeに飛ばす
            }
        }
    }
    
    func logInErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
                case .userNotFound:
                    message = "アカウントが見つかりませんでした"
                case .wrongPassword:
                    message = "パスワードを確認してください"
                case .userDisabled:
                    message = "アカウントが無効になっています"
                case .invalidEmail:
                    message = "Eメールが無効な形式です"
                default: message = "エラー: \(error.localizedDescription)"
            }
            showErrorAlert(text: message)
        }
    }
    

    
    
   

}
