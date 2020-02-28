//
//  SignUp5ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp5ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var hobbyTV: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationbarのタイトル設定
        self.title = "サービス利用者情報"
        
        //角丸
        hobbyTV.layer.cornerRadius = 6.0
        nextBtn.layer.cornerRadius = 6.0
        
        
    }

    @IBAction func tapToNext(_ sender: Any) {
        if hobbyTV.text!.isEmpty == false{
            let vc = SignUp6ViewController()
//            let lastVC = SignUp8ViewController()
            SeniorUser.shared.CharaHob = hobbyTV.text!
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }else{
            showErrorAlert(text: "サービス利用者の趣味または性格を入力してください")
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
}
