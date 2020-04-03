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
    

//    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let cellText = ["プロフィール", "お支払い情報", "レビュー", "設定", "ログアウト"]
    let detailText = ["プロフィールを閲覧・編集できます", "お支払い情報をか閲覧・編集できます", "レビューの閲覧・投稿できます", "各種設定を行えます", "ログアウトできます"]
    let cellicon = ["person", "creditcard", "square.and.pencil", "gear", "lock"]
    
    //プロフィール画像表示用のimageView
    let profileImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "マイアカウント"

//        logoutBtn.layer.cornerRadius = logoutBtn.frame.height / 2
//        logoutBtn.backgroundColor = UIColor(red: 244/255, green: 176/255, blue: 131/255, alpha: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
//        tableView.backgroundColor = .black
        navigationController?.navigationBar.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += self.additionalSafeAreaInsets.top
            gradient.frame = bounds
            gradient.colors = [UIColor(red: 41/255, green: 162/255, blue: 226/255, alpha: 1).cgColor, UIColor(red: 65/255, green: 132/255, blue: 190/255, alpha: 1).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)

            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }

    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //デフォルトのtableViewCellを使用
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //内容
        cell.textLabel!.text = cellText[indexPath.row]
        //左端のイメージアイコン設置
        cell.imageView!.image = UIImage(systemName: cellicon[indexPath.row])
        //内容詳細
        cell.detailTextLabel!.text = detailText[indexPath.row]
        cell.detailTextLabel!.tintColor = UIColor.darkGray
        //セルの右端にタッチ利用可能の補助イメージ
        let touchImage = UIImageView()
        touchImage.image = UIImage(systemName: "chevron.right")
        touchImage.frame = CGRect(x: UIScreen.main.bounds.width - 32, y: 26, width: 8, height: 12)
         
        cell.contentView.addSubview(touchImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //プロフィール写真用のUIImageView
//        let profileImage = UIImageView()
        //storageからimageを引っ張ってきてセットする
        if let imageName: String? = seniorProfile.imageName, let ref = SeniorUserCollection.shared.getImageRef(imageName: imageName!){
            profileImage.sd_setImage(with: ref)
        }else{
            profileImage.image = UIImage(systemName: "person.fill")
        }
        profileImage.frame = CGRect(x: (UIScreen.main.bounds.width - 60) / 2, y: 32, width: 60, height: 60)
        profileImage.layer.cornerRadius = 30.0
        
        //サービス利用者氏名を表示
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 32, y: 108, width: UIScreen.main.bounds.width - 64, height: 22)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.text = "\(seniorProfile.sName) さん"
        
        //上記2個をセットするUIViewを定義
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        headerView.addSubview(profileImage)
        headerView.addSubview(nameLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = SeniorDetailProfileViewController()
            vc.imageView.image = profileImage.image
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            return
        case 2:
            return
        case 3:
            return
        default:
            do {
                try Auth.auth().signOut()
//                ReservationCollection.shared.resetData()
                    // 強制的に現在の表示している vc を変更する
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateInitialViewController()

                let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = vc
            } catch {
                print("error:",error.localizedDescription)
            }
        }
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
}
