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

var profile = SeniorUserCollection.shared.createSeniorUser()
var seniorImage: UIImage?

class SignUp8ViewController: UIViewController {
    
    // Firestore へのアクセスに使う
    let db = Firestore.firestore()
    // Storage へのアクセスに使う
    let storage = Storage.storage()
    
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var aNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //profileImageに値が渡されている場合、userImageに表示
        if let seniorImage = seniorImage{
            userImage.image = seniorImage
        }
        
        //profileのidに
        profile.uid = user!.uid
        //navigationBarのタイトル設定
        self.title = "登録情報確認"
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
                profile.imageName = imageName
                SeniorUserCollection.shared.addTask(profile)
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
