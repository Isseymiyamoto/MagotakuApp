//
//  StudentReservationListViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/24.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI

class StudentReservationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // この ViewController で delegate のメソッドを使うために記述している。
        tableView.delegate = self
        // この ViewController で datasouce のメソッドを使うために記述している。
        tableView.dataSource = self
        // nib と xib はほぼ一緒
        let nib = UINib(nibName: "ReservationCell", bundle: nil)
        // tableView に使う xib ファイルを登録している。
        tableView.register( nib, forCellReuseIdentifier: "ReservationCell")
        
        StudentReservationCollection.shared.delegate = self as? StudentReservationCollectionDelegate 
        
        
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        
        if StudentReservationCollection.shared.getPersonalReservationCount() == 0{
            setZeroReservation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        tableView.reloadData()
        
        if StudentReservationCollection.shared.getPersonalReservationCount() == 0{
            setZeroReservation()
        }
    }

    //予約0件の時のみ表示するメソッド
    func setZeroReservation(){
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        self.view.addSubview(view)
        //「確定している予約 0件」表示用のラベル
        let zeroLable = UILabel()
        zeroLable.text = "確定している予約 0件"
        zeroLable.font = UIFont.boldSystemFont(ofSize: 16)
        zeroLable.frame = CGRect(x: 24, y: 24, width: UIScreen.main.bounds.width - 16, height: 22)
        view.addSubview(zeroLable)
        //予約を促す ラベル
        let stimulatorLabel = UILabel()
        stimulatorLabel.text = "次の予約を行いましょう"
        stimulatorLabel.font = UIFont.systemFont(ofSize: 14)
        stimulatorLabel.frame = CGRect(x: 24, y: 54, width: UIScreen.main.bounds.width - 16, height: 22)
        view.addSubview(stimulatorLabel)
        //予約を行うためのボタン
        let reservationBtn = UIButton(type: .system)
        reservationBtn.setTitle("新規予約を行う", for: .normal)
        reservationBtn.setTitleColor(.white, for: .normal)
        reservationBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        reservationBtn.titleLabel?.textAlignment = .center
        reservationBtn.backgroundColor = UIColor(red: 94/255, green: 123/255, blue: 211/255, alpha: 1)
        reservationBtn.frame = CGRect(x: 24, y: 88, width: 240, height: 48)
        reservationBtn.layer.cornerRadius = 6.0
        view.addSubview(reservationBtn)
        
    }

    //1セクション内のrowの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentReservationCollection.shared.getPersonalReservationCount()
    }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //デフォルトのtableViewCellを使用
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
       //日付
        cell.textLabel!.text = "\(StudentReservationCollection.shared.getPersonalReservation(at: indexPath.row).visitDate) \(StudentReservationCollection.shared.getPersonalReservation(at: indexPath.row).visitTime)"
       //左端のシニア画像配置
    if let imageName: String = StudentReservationCollection.shared.getPersonalReservation(at: indexPath.row).seniorImage, let ref = StudentReservationCollection.shared.getImageRef(uid: StudentReservationCollection.shared.getPersonalReservation(at: indexPath.row).seUid, imageName: imageName){
        cell.imageView!.sd_setImage(with: ref)
        cell.imageView!.frame = CGRect(x: 16, y: 18, width: 60, height: 60)
        cell.imageView!.contentMode = .scaleToFill
        cell.imageView!.layer.cornerRadius = 30.0
       }else{
        cell.imageView!.image = UIImage(systemName: "person.circle")
       }
       //シニア側の名前
    cell.detailTextLabel!.text = "訪問相手： \(StudentReservationCollection.shared.getPersonalReservation(at: indexPath.row).seUid)"
       cell.detailTextLabel!.tintColor = UIColor.darkGray
       //セルの右端にタッチ利用可能の補助イメージ
       let touchImage = UIImageView()
       touchImage.image = UIImage(systemName: "chevron.right")
       touchImage.frame = CGRect(x: UIScreen.main.bounds.width - 32, y: 42, width: 8, height: 12)

       cell.contentView.addSubview(touchImage)
       return cell
   }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    

}

// extension で分けた方が見やすくなる
extension StudentReservationListViewController: StudentReservationCollectionDelegate {
    // デリゲートのメソッド
    func saved() {
        // tableView をリロードして、画面を更新する。
        tableView.reloadData()
    }
    
    func loaded() {
        tableView.reloadData()
    }
}

