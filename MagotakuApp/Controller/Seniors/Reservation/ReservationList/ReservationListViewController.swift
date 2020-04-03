//
//  ReservationListViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/05.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

//Reservationタブ左側「予約一覧」用のUIViewController

import UIKit
import FirebaseFirestore
import FirebaseUI

class ReservationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
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
        
        ReservationCollection.shared.delegate = self as? ReservationCollectionDelegate
        
        print(ReservationCollection.shared.reservationCount())
        
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        
//        if ReservationCollection.shared.reservationCount() == 0{
//            //予約0件の場合のみ表示する
//            setZeroReservation()
//        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
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
        return ReservationCollection.shared.reservationCount()
    }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // 登録したセルを使う。 as! CustomCell としないと、UITableViewCell のままでしか使えない。
       let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationCell
    
            //日付用のUILabelに代入
            cell.dateLabel.text = "\(ReservationCollection.shared.getReservation(at: indexPath.row).visitDate) \(ReservationCollection.shared.getReservation(at: indexPath.row).visitTime)"
            //もし承認判定用の番号が1になっていたらテキストカラーと文言を変更
            if ReservationCollection.shared.getReservation(at: indexPath.row).reservationNum == 1{
                cell.decideLabel.text = " 承認済み "
                cell.decideLabel.textColor = .red
                cell.decideLabel.layer.borderColor = UIColor.red.cgColor
                
                if let imageName: String = ReservationCollection.shared.getReservation(at: indexPath.row).studentImage,
                    let ref = ReservationCollection.shared.getImageRef(uid: ReservationCollection.shared.getReservation(at: indexPath.row).stUid, imageName: imageName){
                    cell.partnerImage.sd_setImage(with: ref)
    
                }else{
                    cell.partnerImage.image = UIImage(systemName: "person.fill")
                }
                
            }else{
                //承認されていない場合、imageViewにひとまずログインユーザーの顔写真を挿入する
                if let imageName: String = seniorProfile.imageName, let ref = SeniorUserCollection.shared.getImageRef(imageName: imageName){
                    cell.partnerImage.sd_setImage(with: ref)
                }
                cell.partnerLabel.text = "パートナー：未定"
            }
       return cell
   }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ReservationCollection.shared.getReservation(at: indexPath.row).reservationNum == 1{
            let vc = ReservationDetailViewController()
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }else{
            notDoneAlert(text: "まだパートナーが未定です。お決まりまでお待ちください")
        }
        
    }
    
    

}

// extension で分けた方が見やすくなる
extension ReservationListViewController: ReservationCollectionDelegate {
    // デリゲートのメソッド
    func saved() {
        // tableView をリロードして、画面を更新する。
        tableView.reloadData()
    }
    
    func loaded() {
        tableView.reloadData()
    }
}

