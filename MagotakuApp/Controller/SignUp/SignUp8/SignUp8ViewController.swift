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
    
    @IBOutlet weak var aNameLabel: UILabel!
    let user = Auth.auth().currentUser
//    var userInfo = SeniorUser(id: "uid")
    @IBOutlet weak var userImage: UIImageView!
    var getImage: UIImage!
    
    var sName:String?
    var aName:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("出力じゃい")
        print(SeniorUser.shared)
        print(SeniorUser.shared.aName! as Any)
        print(SeniorUser.shared.sName!)
        print("でた？")
        
       
        
        
        userImage.image = self.getImage
        
        
        
        //navigationBarのタイトル設定
        self.title = "登録情報確認"
    }


  
}
