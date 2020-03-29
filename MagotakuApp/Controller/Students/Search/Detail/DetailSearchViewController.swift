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
    var seniorImage: UIImage!
    
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 120
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
//        let a = UIButton(type: .system)
//        a.setTitle("俺は俺", for: .normal)
//        a.frame = CGRect(x: 12, y: 12, width: 12, height: 12)
//        view.addSubview(a)
//        
//        //プロフィール写真用のUIImageView
//        let profileImage = UIImageView()
//        //storageからimageを引っ張ってきてセットする
//        if let imageName: String? = seniorProfile.imageName, let ref = SeniorUserCollection.shared.getImageRef(imageName: imageName!){
//            profileImage.sd_setImage(with: ref)
//        }
//        profileImage.frame = CGRect(x: (UIScreen.main.bounds.width - 60) / 2, y: 32, width: 60, height: 60)
//        profileImage.layer.cornerRadius = 30.0
//
//        //サービス利用者氏名を表示
//        let nameLabel = UILabel()
//        nameLabel.frame = CGRect(x: 32, y: 108, width: UIScreen.main.bounds.width - 64, height: 22)
//        nameLabel.textAlignment = .center
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        nameLabel.text = "\(seniorProfile.sName) さん"
//
//        //上記2個をセットするUIViewを定義
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
//        headerView.addSubview(profileImage)
//        headerView.addSubview(nameLabel)
//
//        return headerView
        return view
    }
    
        

   

}
