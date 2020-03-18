//
//  ProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/03.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let cellText = ["登録内容", "ご利用可能なサービス", "訪問履歴", "設定"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "マイアカウント"
//        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        titleView.image = UIImage(systemName: "paperclip.circle.fill")
//        self.navigationItem.titleView = titleView
//
        logoutBtn.layer.cornerRadius = logoutBtn.frame.height / 2
        logoutBtn.backgroundColor = UIColor(red: 244/255, green: 176/255, blue: 131/255, alpha: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

    
    @IBAction func logout(_ sender: Any) {
        do {
                try Auth.auth().signOut()
                // 強制的に現在の表示している vc を変更する
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateInitialViewController()

                let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = vc
            } catch {
                print("error:",error.localizedDescription)
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel!.text = cellText[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //プロフィール写真用のUIImageView
        let profileImage = UIImageView()
        if let imageName: String? = profile.imageName, let ref = SeniorUserCollection.shared.getImageRef(imageName: imageName!){
            profileImage.sd_setImage(with: ref)
        }
        profileImage.frame = CGRect(x: (UIScreen.main.bounds.width - 48) / 2, y: 32, width: 48, height: 48)
        profileImage.layer.cornerRadius = 24.0
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 32, y: 96, width: UIScreen.main.bounds.width - 64, height: 22)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.text = profile.sName
        
        let headerView = UIView()
        headerView.addSubview(profileImage)
        headerView.addSubview(nameLabel)
        
        return headerView
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//            let myLable = UILabel()
//            myLable.frame = CGRect(x: 16, y: (UIScreen.main.bounds.height / 16 - 24) / 2, width: UIScreen.main.bounds.width - 32, height: 24)
//            myLable.font = UIFont.boldSystemFont(ofSize: 12)
//            myLable.text = "入力した内容に間違いがないかご確認ください"
//
//            let headerView = UIView()
//        if section == 0{
//            headerView.addSubview(myLable)
//        }
//            return headerView
//    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
}
