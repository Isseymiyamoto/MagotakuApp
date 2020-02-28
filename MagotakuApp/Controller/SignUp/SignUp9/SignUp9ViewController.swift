//
//  SignUp9ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUp9ViewController: UIViewController{
    
    //ログインしているユーザー情報の取得
    let user = Auth.auth().currentUser
    
    
    let screenWidth = UIScreen.main.bounds.size.width
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBar用のタイトル
        self.title = "登録内容確認"
        
        //tableViewのプロトコル設定
//        tableView.delegate = self
//        tableView.dataSource = self
        
        
        
    }

    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }

    

}
