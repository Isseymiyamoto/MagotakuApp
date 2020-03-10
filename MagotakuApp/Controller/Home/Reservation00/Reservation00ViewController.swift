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
    
    //UIDatePickerを定義するための変数
    var datePicker: UIDatePicker = UIDatePicker()

    
    //tableViewに使用する値
    private let sections: [[String]] = [
        ["訪問希望日"],
        ["開始時間", "利用時間"]
    ]
    
    
    
    //スクリーンを取得
    let x = UIScreen.main.bounds
    

    @IBOutlet weak var tableView: UITableView!
    
    //カレンダーで選択した値が入る
    var decidedDate: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBarのタイトル設定
        self.title = "新規予約"
        
        //プロトコルの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        //UIViewのbackgroundを設定
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)

    }
    
    override func viewDidLayoutSubviews() {
        tabBarController?.tabBar.isHidden = true
        
        nextBtn.frame = CGRect(x: 32, y: x.height - 108, width: x.width - 64, height: 48)
        nextBtn.layer.cornerRadius = 24
        
        
        //nabvigationBarの位置を取得
//        let navXPoint: CGFloat = (navigationController!.navigationBar.frame.origin.x)
//        let navHeight: CGFloat = (navigationController?.navigationBar.frame.height)!
//
//        print(navXPoint)
//        print(navHeight)
//
//        kakunin.frame = CGRect(x: 0, y: 68, width: 12, height: 12)
        
       
        
    }

    //sectionの中に何個セル(row)が入るのか
    //[section]のsectionは引数sectionを使用しているだけ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    
    //セルを構築する際に呼ばれるメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = sections[indexPath.section][indexPath.row]
        return cell
    }
    
    //全体としてのセクション数は幾つなのか
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return ""
//    }
    
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
    
   
    
    
  

}
