//
//  SignUp3ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp3ViewController: UIViewController{
    
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    //生年月日が入力されるTF
    let birthdateTF: CustomTextField! = CustomTextField()
    
    //UIDatePickerを定義するための変数
    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        //NavigationBarのタイトル設定
        self.title = "サービス利用者情報"
        
        //TFの設定
        birthdateTF.placeholder = "例:1960年12月8日"
        birthdateTF.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        birthdateTF.layer.cornerRadius = 6
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
//        birthdateTF.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー設定(紐づいているUITextfieldへ代入)
        birthdateTF.inputView = datePicker
        birthdateTF.inputAccessoryView = toolbar
        
        self.view.addSubview(birthdateTF)

        nextBtn.layer.cornerRadius = 6.0


    }
    
    // UIDatePickerのDoneを押したら発火
    @objc func done() {
        birthdateTF.endEditing(true)

        // 日付のフォーマット
        let formatter = DateFormatter()

        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "yyyy年MM月dd日"

        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        birthdateTF.text = "\(formatter.string(from: datePicker.date))"
    }

    
    override func viewDidLayoutSubviews() {
        let labelLoc:CGFloat? = birthLabel.frame.origin.y
        print(labelLoc!)
        self.birthdateTF.frame = CGRect(x: 32, y: labelLoc! + 40, width: UIScreen.main.bounds.size.width - 64, height: 48)
    }
    
 
    @IBAction func tapToNext(_ sender: Any) {
        if birthdateTF.text?.isEmpty == false{
            let vc = SignUp4ViewController()
//            let lastVC = SignUp8ViewController()
//            SeniorUser.shared.bornDate = birthdateTF.text!
            seniorProfile.bornDate = birthdateTF.text!
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }else{
            showErrorAlert(text: "サービス利用者の生年月日を入力してください")
        }
    }
    
}
