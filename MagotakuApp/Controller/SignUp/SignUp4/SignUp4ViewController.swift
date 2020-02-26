//
//  SignUp4ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp4ViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let addressNumTF:CustomTextField! = CustomTextField()
    let address1TF:CustomTextField! = CustomTextField()
    let address2TF:CustomTextField! = CustomTextField()
    let phoneTF:CustomTextField! = CustomTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        //NavigationBarのタイトル設定
        self.title = "サービス利用者情報"
        
        //サービス利用者側のTFの配置
        setTF(TF: addressNumTF, placeholder: "郵便番号")
        setTF(TF: address1TF, placeholder: "住所1(県・市・区)")
        setTF(TF: address2TF, placeholder: "住所2")
        setTF(TF: phoneTF, placeholder: "固定電話もしくは携帯電話番号")
        
    }
    
    override func viewDidLayoutSubviews() {
        let addLoc:CGFloat? = addressLabel.frame.origin.y
        print(addLoc!)
        
        //4つのTFを描画する
    
    }


    func setTF(TF: UITextField, placeholder: String){
        TF.placeholder = placeholder
        TF.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        TF.layer.cornerRadius = 6.0
        self.view.addSubview(TF)
    }

}
