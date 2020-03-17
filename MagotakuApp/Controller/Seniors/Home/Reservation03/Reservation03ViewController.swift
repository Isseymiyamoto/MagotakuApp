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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "確認画面"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // nib と xib はほぼ一緒
        let nib = UINib(nibName: "CustomCell3", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib, forCellReuseIdentifier: "CustomCell3")
        
        //ログインしてるか確認
        if let user = Auth.auth().currentUser{
            reservation.seUid = user.uid
        }
        
        
        registerBtn.layer.cornerRadius = 24.0
        
        //UIViewのbackgroundを設定
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }

    
    @IBAction func tapToRegister(_ sender: Any) {
        //Firestoreに予約情報送信
        ReservationCollection.shared.addReservation(reservation)
        
        //予約一覧画面に飛ばす
//        let vc = ReservationViewController()
//        let backButtonItem =  UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backButtonItem
//        navigationController?.pushViewController(vc, animated: true)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                return
        }
        let vc = MainTabBarController()
        sceneDelegate.window?.rootViewController = vc
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            cell.resultLabel.text = "おしゃべり"
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "入力した内容に間違いがないかご確認ください"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  1
    }
    
  

}
