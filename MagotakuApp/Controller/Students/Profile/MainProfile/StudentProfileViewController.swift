//
//  StudentProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StudentProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     @IBOutlet weak var tableView: UITableView!
        
        let cellText = ["プロフィール", "過去の業務と報酬", "レビュー", "設定", "ログアウト"]
        let detailText = ["プロフィールを閲覧・編集できます", "過去の業務と報酬について閲覧できます", "レビューの閲覧・投稿できます", "各種設定を行えます", "ログアウトできます"]
        let cellicon = ["person", "dollarsign.circle", "square.and.pencil", "gear", "lock"]
        
        override func viewDidLoad() {
            super.viewDidLoad()

            self.title = "マイアカウント"
            
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
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
                gradient.endPoint = CGPoint(x: 1, y: 1)

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
            let profileImage = UIImageView()
            //storageからimageを引っ張ってきてセットする
//            if let imageName: String? = seniorProfile.imageName, let ref = SeniorUserCollection.shared.getImageRef(imageName: imageName!){
//                profileImage.sd_setImage(with: ref)
//            }
            profileImage.image = UIImage(systemName: "house")
            profileImage.frame = CGRect(x: (UIScreen.main.bounds.width - 60) / 2, y: 32, width: 60, height: 60)
            profileImage.layer.cornerRadius = 30.0
            
            //サービス利用者氏名を表示
            let nameLabel = UILabel()
            nameLabel.frame = CGRect(x: 32, y: 108, width: UIScreen.main.bounds.width - 64, height: 22)
            nameLabel.textAlignment = .center
            nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            nameLabel.text = "\(studentProfile.name) さん"
            
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
                return
            case 1:
                return
            case 2:
                return
            case 3:
                return
            default:
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
