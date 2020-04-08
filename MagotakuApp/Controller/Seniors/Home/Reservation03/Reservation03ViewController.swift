//
//  Reservation03ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/13.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase

var reservation = ReservationCollection.shared.createReservation()

class Reservation03ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //tableViewに設置する値
    let setLabels: [String] = ["希望日時", "希望時間", "サービス提供時間", "希望するお手伝い内容"]
    let helpContents = ["傾聴", "ITレッスン", "家事", "散歩", "おしゃべり", "その他"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "確認画面"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // nib と xib はほぼ一緒
        let nib = UINib(nibName: "CustomCell3", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib, forCellReuseIdentifier: "CustomCell3")
        
        // nib と xib はほぼ一緒
        let nib2 = UINib(nibName: "CustomCell4", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib2, forCellReuseIdentifier: "CustomCell4")
        
        //ログインしてるか確認
        if let user = Auth.auth().currentUser{
            reservation.seUid = user.uid
            //seniorのimageURLを挿入
            reservation.seniorImage = seniorProfile.imageName
        }
        
        
        registerBtn.layer.cornerRadius = 24.0
        
        //UIViewのbackgroundを設定
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        
        
        //test
        moneyExpected()
    }

    
    @IBAction func tapToRegister(_ sender: Any) {
        //予想時間から予想金額を設定する関数をおく
        
        reservation.ExpectedPrice = "2000"
        //Firestoreに予約情報送信
        ReservationCollection.shared.addReservation(reservation)
        
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                return
        }
        //AddReservationした後にreservationを新しく生成する
        reservation = ReservationCollection.shared.createReservation()
        
        let vc = MainTabBarController()
        sceneDelegate.window?.rootViewController = vc
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return setLabels.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            //サービス提供時間
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell3", for: indexPath) as! CustomCell3
            cell.titleLabel.text = setLabels[indexPath.row]
            
            switch indexPath.row {
                case 0:
                    cell.resultLabel.text = reservation.visitDate
                case 1:
                    cell.resultLabel.text = reservation.visitTime
                case 2:
                    cell.resultLabel.text = reservation.vistHour
            default:
                cell.resultLabel.text = ""
                for i in 0..<reservation.helpContents!.count{
                    cell.resultLabel.text! += "\(helpContents[reservation.helpContents![i]])    "
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell4", for: indexPath) as! CustomCell4
            return cell
        }
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 72
        default:
            return 160
        }
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let myLable = UILabel()
            myLable.frame = CGRect(x: 16, y: (UIScreen.main.bounds.height / 16 - 24) / 2, width: UIScreen.main.bounds.width - 32, height: 24)
            myLable.font = UIFont.boldSystemFont(ofSize: 12)
            myLable.text = "入力した内容に間違いがないかご確認ください"
            
            let headerView = UIView()
        if section == 0{
            headerView.addSubview(myLable)
        }
            return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 16
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  1
    }
    
    //予想時間から予想金額を設定する関数
    func moneyExpected(){
        //サービス提供時間を取得
        var serviceString = reservation.vistHour
        //サービス提供時間をInt型の時間数に変換する
        if let range = serviceString.range(of: "時間"){
            serviceString.replaceSubrange(range, with: "：")
        }
        if let range = serviceString.range(of: "分"){
            serviceString.replaceSubrange(range, with: "")
        }
        
        print(serviceString)
        //Int型の時間数 * 1200yen + 交通費 500yen = 予想金額とする
    }
    
  

}
