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
        cell.decideLabel.text = "承認済み"
        cell.decideLabel.textColor = .red
        cell.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
    }else{
        //承認されていない場合、imageViewにひとまずログインユーザーの顔写真を挿入する
        if let imageName = profile.imageName, let ref = SeniorUserCollection.shared.getImageRef(imageName: imageName){
            cell.partnerImage.sd_setImage(with: ref)
        }
    }
    
    
    
       return cell
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

