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

class SignUp8ViewController: UIViewController {
    
    // Firestore へのアクセスに使う
    let db = Firestore.firestore()
    // Storage へのアクセスに使う
    let storage = Storage.storage()
    
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var aNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var getImage: UIImage!
    var sName:String?
    var aName:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("出力じゃい")
        print("でた？")
        
//        userImage.image = SeniorUser.shared.userImage
        profile.id = user!.uid
        //navigationBarのタイトル設定
        self.title = "登録情報確認"
    }
    
    
    
    //登録処理
    @IBAction func tapToRegister(_ sender: Any) {
        //firebaseに値を保存
        SeniorUserCollection.shared.addTask(profile)
        //遷移先に飛ばす
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

  
}
