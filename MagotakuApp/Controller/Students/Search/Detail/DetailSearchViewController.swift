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
            return 160
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //プロフィール写真用のUIImageView
        let profileImage = UIImageView()
        profileImage.frame = CGRect(x: (UIScreen.main.bounds.width - 72) / 2, y: 32, width: 72, height: 72)
        profileImage.layer.cornerRadius = 30.0
        profileImage.image = seniorImage

        //サービス利用者詳細情報に飛ばすbtn設置
        let detailBtn = UIButton(type: .system)
        detailBtn.frame = CGRect(x: 32, y: 108, width: UIScreen.main.bounds.width - 64, height: 22)
        detailBtn.titleLabel?.textAlignment = .center
        detailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        detailBtn.setTitle("詳細プロフィール", for: .normal)
        detailBtn.addTarget(self, action: #selector(tapDetailProfile), for: .touchUpInside)

        //各パーツを載せるためのUIView
        let view = UIView()
        view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.addSubview(profileImage)
        view.addSubview(detailBtn)
        
        
        return view
    }
    
    //detailBtn用のメソッド
    @objc func tapDetailProfile(){
        let vc = ProfileViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
        

   

}
