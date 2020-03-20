//
//  Reservation00ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/07.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class Reservation00ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //次へボタンの設定
    @IBOutlet weak var nextBtn: UIButton!
    
    var cell :CustomCell!
    var cell1: UITableViewCell!
    var cell2: CustomCell2!
    
    
    //tableViewに使用する値
    private let sections: [[String]] = [
        ["訪問希望日"],
        ["開始時間", "利用時間"]
    ]
    
    //スクリーンを取得
    let x = UIScreen.main.bounds
    
    
    //2セクション目のTFに入るテキスト
    var selectDate: String!
    var selectDate2: String!
    
    //1セクションのcontentViewに入るテキスト
    var calendarDate: String = ""
    
   
    
    //UIDatePickerを定義するための変数
    var datePicker: UIDatePicker = UIDatePicker()
    var datePicker2: UIDatePicker = UIDatePicker()
    
    


    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBarのタイトル設定
        self.title = "訪問希望日を選択して下さい"
        
        self.view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        
        //プロトコルの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        //UIViewのbackgroundを設定
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        
        // nib と xib はほぼ一緒
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib, forCellReuseIdentifier: "CustomCell")
        
        // nib と xib はほぼ一緒
        let nib2 = UINib(nibName: "CustomCell2", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib2, forCellReuseIdentifier: "CustomCell2")
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBarController?.tabBar.isHidden = true
        
//        nextBtn.frame = CGRect(x: 32, y: x.height - 108, width: x.width - 64, height: 48)
        nextBtn.layer.cornerRadius = 24
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

   

    //sectionの中に何個セル(row)が入るのか
    //[section]のsectionは引数sectionを使用しているだけ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(76)
    }
    
    
    //セルを構築する際に呼ばれるメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0{
            //訪問希望月日
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell1.textLabel?.text = sections[indexPath.section][indexPath.row]
            
            cell1.detailTextLabel?.text = calendarDate
            cell1.detailTextLabel?.textColor = UIColor.black
            return cell1
        }else if indexPath.section == 1 && indexPath.row == 0{
            //訪問希望時間
            cell = (tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell)
            cell.textLabel?.text = sections[indexPath.section][indexPath.row]
            cell.customTF.borderStyle = .none
            cell.customTF.tintColor = .clear
            cell.customTF.placeholder = "例: 午前12:00"
            cell.customTF.text = selectDate
            datePicker = cell.datePicker
            cell.customTF.inputView = datePicker
            
            // 決定バーの生成
                  let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
                  let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                  let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDate))
                  toolbar.setItems([spacelItem, doneItem], animated: true)
            cell.customTF.inputAccessoryView = toolbar
            
            return cell
        }else{
            //サービス提供時間
            cell2 = (tableView.dequeueReusableCell(withIdentifier: "CustomCell2", for: indexPath) as! CustomCell2)
            cell2.textLabel?.text = sections[indexPath.section][indexPath.row]
            cell2.customTF2.borderStyle = .none
            cell2.customTF2.tintColor = .clear
            cell2.customTF2.placeholder = "例: 2時間"
            cell2.customTF2.text = selectDate2
            datePicker2 = cell2.datePicker2
            cell2.customTF2.inputView = datePicker2
            // 決定バーの生成
                      let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
                      let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
                      let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDate2))
                      toolbar.setItems([spacelItem, doneItem], animated: true)
            cell2.customTF2.inputAccessoryView = toolbar
            return cell2
        }
    }
    
    //全体としてのセクション数は幾つなのか
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //タップされたセルのセクション番目の取得
        print(indexPath.section)
        //タップされたセルのrow番目の取得
        print(indexPath.row)
        
        //セルの場所で処理を分岐
        if indexPath.section == 0 && indexPath.row == 0{
            //カレンダーを配置しているReservation01VCに遷移させる
            let vc = Reservation01ViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 1 && indexPath.row == 0{
            cell.customTF.becomeFirstResponder()
        }else{
            cell2.customTF2.becomeFirstResponder()
        }
        
        
    }
    
    //tableViewのheaderの高さ設定
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return CGFloat(x.height / 20)
        default:
            return CGFloat(x.height / 20)
        }
    }
    
    //tableViewのfooterの高さ設定
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
    
   
    
    @IBAction func tapToNext(_ sender: Any) {
        //reservationに値を代入
        //訪問希望月日
        reservation.visitDate = calendarDate
        //訪問希望時間
        reservation.visitTime = cell.customTF.text!
        //サービス提供時間
        reservation.vistHour = cell2.customTF2.text!
        
        
        
        let vc = Reservation02ViewController()
        let backButtonItem =  UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func setDate() {
       let f = DateFormatter()
       f.timeStyle = .short
       f.locale = Locale(identifier: "ja")
        f.dateFormat = "h時mm分"
        selectDate = f.string(from: datePicker.date)
        tableView.reloadData()
    }
    
    @objc func setDate2() {
       let f = DateFormatter()
       f.timeStyle = .short
        f.dateFormat = "h時間mm分"
       f.locale = Locale(identifier: "ja")
        selectDate2 = f.string(from: datePicker2.date)
        tableView.reloadData()
    }
  

}
