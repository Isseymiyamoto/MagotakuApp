//
//  SignUp3ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp3ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    //生年月日が入力されるTF
    let birthdateTF: CustomTextField! = CustomTextField()
    
    //pickerViewに反映される変数定義
    let years = (1920...2015).map { $0 }
    let months = (1...12).map { $0 }
    let days = (1...30).map { $0 }

    override func viewDidLoad() {
        super.viewDidLoad()

        //NavigationBarのタイトル設定
        self.title = "サービス利用者情報"
        
        //TFの設定
        birthdateTF.placeholder = "例:1960年12月8日"
        birthdateTF.backgroundColor = UIColor(red: 232/255, green: 234/255, blue: 240/255, alpha: 1)
        birthdateTF.layer.cornerRadius = 6
    
        //pickerViewの設定
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        birthdateTF.inputView = pickerView
        
        self.view.addSubview(birthdateTF)
        
        nextBtn.layer.cornerRadius = 6.0
        
        setKeyboardAccessory()
    }
    
    override func viewDidLayoutSubviews() {
        let labelLoc:CGFloat? = birthLabel.frame.origin.y
        print(labelLoc!)
        self.birthdateTF.frame = CGRect(x: 32, y: labelLoc! + 40, width: UIScreen.main.bounds.size.width - 64, height: 48)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return years.count
        }else if component == 1{
            return months.count
        }else if component == 2{
            return days.count
        }else{
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return "\(years[row])年"
        }else if component == 1{
            return "\(months[row])月"
        }else if component == 2{
            return "\(days[row])日"
        }else{
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[pickerView.selectedRow(inComponent: 0)]
        let month = months[pickerView.selectedRow(inComponent: 1)]
        let day = days[pickerView.selectedRow(inComponent: 2)]
        birthdateTF.text = "\(year)年\(month)月\(day)日"
    }
    
    func setKeyboardAccessory() {
        let keyboardAccessory = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 36))
        keyboardAccessory.backgroundColor = UIColor.white
        birthdateTF.inputAccessoryView = keyboardAccessory
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: keyboardAccessory.bounds.size.width, height: 0.5))
        topBorder.backgroundColor = UIColor.lightGray
        keyboardAccessory.addSubview(topBorder)
        
        let completeBtn = UIButton(frame: CGRect(x: keyboardAccessory.bounds.size.width - 48, y: 0, width: 48, height: keyboardAccessory.bounds.size.height - 0.5 * 2))
        completeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        completeBtn.setTitle("完了", for: .normal)
        completeBtn.setTitleColor(UIColor.blue, for: .normal)
        completeBtn.setTitleColor(UIColor.red, for: .highlighted)
        completeBtn.addTarget(self, action: #selector(hidePickerView), for: .touchUpInside)
        keyboardAccessory.addSubview(completeBtn)
        
        let bottomBorder = UIView(frame: CGRect(x: 0, y: keyboardAccessory.bounds.size.height - 0.5, width: keyboardAccessory.bounds.size.width, height: 0.5))
        bottomBorder.backgroundColor = UIColor.lightGray
        keyboardAccessory.addSubview(bottomBorder)
    }

    @objc func hidePickerView() {
        birthdateTF.resignFirstResponder()
    }

 
    @IBAction func tapToNext(_ sender: Any) {
        if birthdateTF.text != nil{
            let vc = SignUp4ViewController()
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
