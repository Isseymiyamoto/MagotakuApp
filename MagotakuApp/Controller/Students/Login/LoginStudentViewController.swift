//
//  LoginStudentViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/14.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginStudentViewController: UIViewController, UITextFieldDelegate {
    
    let mailTF: CustomTextField! = CustomTextField()
    let passwordTF: CustomTextField! = CustomTextField()
    @IBOutlet weak var loginBtn: UIButton!
    var bottomMargin:CGFloat? = nil

    override func viewDidLoad() {
            super.viewDidLoad()
            
            
            self.mailTF.delegate = self
            self.passwordTF.delegate = self
            
            self.passwordTF.isSecureTextEntry = true
            
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
            
            //navigationBarの配置
            // navigationBarのタイトル
            self.title = "学生側ログイン"
            //　ナビゲーションバーの背景色
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 35/255, blue: 57/255, alpha: 1)
            // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
            self.navigationController?.navigationBar.tintColor = .white
            // ナビゲーションバーのテキストを変更する
            self.navigationController?.navigationBar.titleTextAttributes = [
            // 文字の色
                .foregroundColor: UIColor.white
            ]
            
            //キーボードの出現を感知
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            navigationController?.navigationBar.isHidden = false
        }
        
        
        //引数、指定箇所のみ角丸にするメソッド
        func partCornerRadius(TF: UITextField, corner1: CACornerMask, corner2: CACornerMask){
            TF.borderStyle = .none
            TF.layer.cornerRadius = TF.frame.height / 4
            TF.layer.maskedCorners = [corner1, corner2]
            TF.layer.borderColor = UIColor.lightGray.cgColor
            TF.layer.masksToBounds = true
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
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                            return
                    }
                    let vc = StudentTabBarController()
                    sceneDelegate.window?.rootViewController = vc
    //                self.navigationController?.pushViewController(vc, animated: true)
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
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                } else {
                    let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                    self.view.frame.origin.y -= suggestionHeight
                }
            }
        }
        
        @objc func keyboardWillHide() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    
    
    
    
    @IBAction func tapToSignUp(_ sender: Any) {
        let vc = SignUpStudentViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
        
        


    
}
