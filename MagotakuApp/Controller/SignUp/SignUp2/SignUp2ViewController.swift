//
//  SignUp2ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase

class SignUp2ViewController: UIViewController {
    
    let user = Auth.auth().currentUser
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var sexNum:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maleBtn.layer.cornerRadius = 6.0
        femaleBtn.layer.cornerRadius = 6.0
        nextBtn.layer.cornerRadius = 6.0
        // NavigationBαrのタイトル
        self.title = "サービス利用者情報"
    }
    
    
    @IBAction func tapMale(_ sender: Any) {
        //男性をタップした際の挙動
        if sexNum == 1 {
            //男性側のbackgroundColor、文字色を元に戻す
            maleBtn.backgroundColor = UIColor.white
            maleBtn.setTitleColor(UIColor.black, for: .normal)
            //sexNumをnilにする
            sexNum = nil
        }else if sexNum == 2{
            //sexNumの数値を1にする
            sexNum = 1
            //backgroundColorを青、文字色を白に変える
            maleBtn.backgroundColor = UIColor(red: 235/255, green: 86/255, blue: 105/255, alpha: 1)
            maleBtn.setTitleColor(UIColor.white, for: .normal)
            //女性側のbackgroundColorと文字色を元に戻す
            femaleBtn.backgroundColor = UIColor.white
            femaleBtn.setTitleColor(UIColor.black, for: .normal)
        }else{
            //sexNumの数値を1にする
            sexNum = 1
            //backgroundColorを青、文字色を白に変える
            maleBtn.backgroundColor = UIColor(red: 235/255, green: 86/255, blue: 105/255, alpha: 1)
            maleBtn.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
    
    @IBAction func tapFemale(_ sender: Any) {
        //女性をタップした際の挙動
        if sexNum == 1{
            //sexNumの数値を2にする
            sexNum = 2
            //男性側のbackgroundColor、文字色を元に戻す
            maleBtn.backgroundColor = UIColor.white
            maleBtn.setTitleColor(UIColor.black, for: .normal)
            //女性側のbackgroundColorと文字色をかえる
            femaleBtn.backgroundColor = UIColor(red: 235/255, green: 86/255, blue: 105/255, alpha: 1)
            femaleBtn.setTitleColor(UIColor.white, for: .normal)
        }else if sexNum == 2{
            //女性側のbackgroundColorと文字色を元に戻す
            femaleBtn.backgroundColor = UIColor.white
            femaleBtn.setTitleColor(UIColor.black, for: .normal)
            //sexNumをnilに
            sexNum = nil
        }else{
            //sexNumの数値を2にする
            sexNum = 2
            //女性側のbackgroundColorと文字色をかえる
            femaleBtn.backgroundColor = UIColor(red: 235/255, green: 86/255, blue: 105/255, alpha: 1)
            femaleBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    
    
    @IBAction func tapToNext(_ sender: Any) {
        //次のVCに遷移
        //sexNumの値がnilでなければ遷移
        if sexNum != nil{
            let vc = SignUp3ViewController()
            let uid = user?.uid
            SeniorUser.shared.id = uid!
//            let lastVC = SignUp8ViewController()
            if sexNum == 1{
                SeniorUser.shared.sex = "男性"
            }else{
                SeniorUser.shared.sex = "女性"
            }
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }else{
            showErrorAlert(text: "性別を選択してください")
        }
        
    }
    
    
    
    
}
