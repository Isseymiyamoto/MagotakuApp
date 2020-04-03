//
//  SignUp0ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUp0ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    //メールアドレスTF
    let mailTF: CustomTextField! = CustomTextField()
    //パスワードTF
    let passwordTF: CustomTextField! = CustomTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // navigationBarのタイトル
        self.title = "アカウント登録"
        //　ナビゲーションバーの背景色
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 35/255, blue: 57/255, alpha: 1)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        self.mailTF.delegate = self
        self.passwordTF.delegate = self
        
        //TFの角丸メソッド
        prepareTF(TF: mailTF, placeholder: "メールアドレス")
        prepareTF(TF: passwordTF, placeholder: "パスワード")
        
        //パスワードを隠すように設定
        passwordTF.isSecureTextEntry = true

        //ボタンの角丸
        nextBtn.layer.cornerRadius = 6
        
        
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += self.additionalSafeAreaInsets.top
            gradient.frame = bounds
            gradient.colors = [UIColor(red: 41/255, green: 162/255, blue: 226/255, alpha: 1).cgColor, UIColor(red: 65/255, green: 132/255, blue: 190/255, alpha: 1).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)

            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
        
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    override func viewDidLayoutSubviews() {
    //        let NavH:CGFloat? = navigationController?.navigationBar.frame.size.height
    //        let topM:CGFloat? = self.view.safeAreaInsets.top
            let labelcgS:CGFloat? = self.mailLabel.frame.origin.y
            let labelcgA:CGFloat? = self.passwordLabel.frame.origin.y
            
            setTF(TF: mailTF, x: 32, y: labelcgS! + 40)
            setTF(TF: passwordTF, x: 32, y: labelcgA! + 40)
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
        TF.frame = CGRect(x: x, y: y, width: UIScreen.main.bounds.size.width - 64 , height: 48)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    //アカウント登録ボタンに紐付ける
    @IBAction func tapSignUpButton(_ sender: Any) {
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
        emailSignUp(email: email, password: password)
    }
  
    
    //サインアップのためのメソッド
    func emailSignUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print ("👿登録失敗:\(error.localizedDescription)")
                self.signUpErrorAlert(error)
            } else {
                print ("🌞登録成功")
                //遷移先に飛ばす
                let vc = SignUp1ViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //サインアップ時に起こるエラーに対するアラート
    func signUpErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .invalidEmail:
                message = "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse:
                message = "既に登録されているメールアドレスです"
            case .weakPassword:
                message = "パスワードは６文字以上で入力してください"
            default:
                message = "エラー: \(error.localizedDescription)"
            }
            showErrorAlert(text: message)
        }
    }

}
