//
//  SignUp4ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp4ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    let addressNumTF:CustomTextField! = CustomTextField()
    let address1TF:CustomTextField! = CustomTextField()
    let address2TF:CustomTextField! = CustomTextField()
    let phoneTF:CustomTextField! = CustomTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        //NavigationBarのタイトル設定
        self.title = "サービス利用者情報"
        
        addressNumTF.delegate = self
        address1TF.delegate = self
        address2TF.delegate = self
        phoneTF.delegate = self
        
        //サービス利用者側のTFの配置
        prepareTF(TF: addressNumTF, placeholder: "郵便番号")
        prepareTF(TF: address1TF, placeholder: "住所1(県・市・区)")
        prepareTF(TF: address2TF, placeholder: "住所2")
        prepareTF(TF: phoneTF, placeholder: "固定電話もしくは携帯電話番号")
        
    }
    
    override func viewDidLayoutSubviews() {
        let addLoc:CGFloat? = addressLabel.frame.origin.y
        let phoneLoc:CGFloat? = phoneLabel.frame.origin.y
        print(addLoc!)
        print(phoneLoc!)
        
        //4つのTFを描画する
        setTF(TF: addressNumTF, y: addLoc! + 40)
        setTF(TF: address1TF, y: addLoc! + 108)
        setTF(TF: address2TF, y: addLoc! + 176)
        setTF(TF: phoneTF, y: phoneLoc! + 40)
    
        nextBtn.layer.cornerRadius = 6.0
    }

    //TFの準備
    func prepareTF(TF: UITextField, placeholder: String){
        TF.placeholder = placeholder
        TF.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        TF.layer.cornerRadius = 6.0
        self.view.addSubview(TF)
    }
    
    //TFの配置
    func setTF(TF:UITextField, y:CGFloat){
        TF.frame = CGRect(x: 32, y: y, width: (UIScreen.main.bounds.size.width) - 64, height: 48)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapToNext(_ sender: Any) {
        if addressNumTF.text!.isEmpty == false && address1TF.text!.isEmpty == false && address2TF.text!.isEmpty == false && phoneTF.text!.isEmpty == false{
            let vc = SignUp5ViewController()
//            let lastVC = SignUp8ViewController()
            SeniorUser.shared.addressNum = addressNumTF.text!
            SeniorUser.shared.address = address1TF.text! + address2TF.text!
            SeniorUser.shared.phoneNumber = phoneTF.text!
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }else{
            showErrorAlert(text: "空欄箇所があります")
        }
        
    }
    

}
