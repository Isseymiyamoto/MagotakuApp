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

class SignUp8ViewController: UIViewController {
    
    let user = Auth.auth().currentUser
    let userInfo = SeniorUser(id: "uid")
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userInfo)
        
        
        
        //navigationBarのタイトル設定
        self.title = "登録情報確認"
    }


  
}
