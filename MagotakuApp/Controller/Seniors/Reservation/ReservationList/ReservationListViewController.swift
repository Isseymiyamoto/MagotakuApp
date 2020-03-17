//
//  ReservationListViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/05.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

//Reservationタブ左側「予約一覧」用のUIViewController

import UIKit

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
    }


    //1セクション内のrowの数を決める
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 30
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // 登録したセルを使う。 as! CustomCell としないと、UITableViewCell のままでしか使えない。
       let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationCell
       return cell
   }

}
