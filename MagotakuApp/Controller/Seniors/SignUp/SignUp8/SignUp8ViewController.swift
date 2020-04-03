//
//  SignUp8ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

var seniorProfile = SeniorUserCollection.shared.createSeniorUser()
//プロフィール画像が渡ってくる
var seniorImage: UIImage?

class SignUp8ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Firestore へのアクセスに使う
    let db = Firestore.firestore()
    // Storage へのアクセスに使う
    let storage = Storage.storage()
    
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewForBtn: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    
    
//    @IBOutlet weak var aNameLabel: UILabel!
//    @IBOutlet weak var userImage: UIImageView!
    
    let titleLabels:[String] = ["アプリ利用者の名前", "あなたの名前", "あなたの生年月日", "あなたの性別", "あなたの電話番号", "あなたの趣味", "あなたの郵便番号","あなたの住所"]
    let imageLists:[String] = ["person.fill", "person.fill", "calendar.circle.fill", "person.crop.rectangle.fill", "phone.fill", "bookmark", "house.fill", "list.number"]
    let profileInfo: [String] = [seniorProfile.aName, seniorProfile.sName, seniorProfile.bornDate, seniorProfile.sex, seniorProfile.phoneNumber, seniorProfile.CharaHob, seniorProfile.addressNum, seniorProfile.address]
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //profileのidに
        seniorProfile.uid = user!.uid
        //navigationBarのタイトル設定
        self.title = "登録情報確認"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //tabbarの高さ取得
        var tabbarHeight = tabBarController?.tabBar.bounds.size.height
        tabbarHeight! += additionalSafeAreaInsets.bottom
        //tableViewのframe
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.bounds.height - tabbarHeight! - 72)
        
        //登録用のviewとbtnのframeを設定する
        viewForBtn.frame = CGRect(x: 0, y: self.view.bounds.height - tabbarHeight! - 72, width: UIScreen.main.bounds.width, height: 72)
        registerBtn.frame = CGRect(x: 32, y: 12, width: UIScreen.main.bounds.width - 64, height: 48)
        registerBtn.layer.cornerRadius = 24
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleLabels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = titleLabels[indexPath.section]
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            cell.imageView?.image = UIImage(systemName: imageLists[indexPath.section])
            //セル選択時にハイライトさせない
            cell.selectionStyle = .none
            return cell
        default:
            let cell1 = UITableViewCell(style: .value1, reuseIdentifier: "cell1")
            cell1.textLabel?.text = profileInfo[indexPath.section]
//            //セルの右端にタッチ利用可能の補助イメージ
//            let touchImage = UIImageView()
//            touchImage.image = UIImage(systemName: "chevron.right")
//            touchImage.frame = CGRect(x: UIScreen.main.bounds.width - 32, y: (cell1.bounds.height / 5) * 2 , width: 8, height: cell1.bounds.height / 5)
//            cell1.contentView.addSubview(touchImage)
            
            return cell1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    //headerViewを設置
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView()
            view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
            
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor(red: 99/255, green: 101/255, blue: 105/255, alpha: 1)
            imageView.frame = CGRect(x: (UIScreen.main.bounds.width / 8) * 3, y: (240 - UIScreen.main.bounds.width / 4) / 2, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
            imageView.layer.cornerRadius = UIScreen.main.bounds.width / 8
//            //タップイベントがブロックされないようにする
//            imageView.isUserInteractionEnabled = true
            view.addSubview(imageView)
//            let button = UIButton(type: .system)
//            button.frame = CGRect(x: UIScreen.main.bounds.width / 4, y:  (UIScreen.main.bounds.width / 4) + (248 - UIScreen.main.bounds.width / 4) / 2, width: UIScreen.main.bounds.width / 2, height: 12)
//            button.setTitle("プロフィール写真を変更", for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//            button.titleLabel?.textAlignment = .center
//            button.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
//            view.addSubview(button)
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 240
        default:
            return 0
        }
    }
    
    
    
    
    //登録処理
    @IBAction func tapToRegister(_ sender: Any) {
        //firebaseに値を保存
        //画像を保存 → profileのimageNmaeに値わたし
        if seniorImage != nil{
            SeniorUserCollection.shared.saveImage(image: seniorImage) { (imageName) in
                guard let imageName = imageName else{
                    return
                }
                seniorProfile.imageName = imageName
                SeniorUserCollection.shared.addTask(seniorProfile)
            }
        }
        
        //遷移先に飛ばす
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                return
        }
        let vc = MainTabBarController()
        sceneDelegate.window?.rootViewController = vc
    }
    

  
}
