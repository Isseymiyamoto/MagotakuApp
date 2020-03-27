//
//  DetailSearchViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class DetailSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //前のVCから値わたしされるようの変数
    var detailNum:Int!
    
    @IBOutlet weak var tableView: UITableView!
    
    var reservationInfo: Reservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "リクエスト詳細"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let detailNum = detailNum{
            print(detailNum)
            reservationInfo = StudentReservationCollection.shared.getReservation(at: detailNum)
        }
        

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = "テストタイトル"
            return cell
        }else{
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = "0"
            case 1:
                cell.textLabel?.text = "0"
            case 2:
                cell.textLabel?.text = "0"
            case 3:
                cell.textLabel?.text = "0"
            case 4:
                cell.textLabel?.text = "0"
            case 5:
                cell.textLabel?.text = "0"
            default:
                cell.textLabel?.text = "0"
            }
            
            return cell
        }
        
        
        
    }
    

   

}
