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
    
    // Firestore へのアクセスに使う
    let db = Firestore.firestore()
    // Storage へのアクセスに使う
    let storage = Storage.storage()
    
    @IBOutlet weak var aNameLabel: UILabel!
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
        
        userImage.image = SeniorUser.shared.userImage
        
        //navigationBarのタイトル設定
        self.title = "登録情報確認"
    }
    
    
    
    func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。") //本番環境では使わない
        }
        return self.db.collection("seniorUsers").document(uid).collection("userInfo")
    }
    
//    func addTask(_ task: SeniorUser){
//        let documentRef = getCollectionRef().document(task.id)
//        let encodeTask = try! Firestore.Encoder().encode(task)
//        documentRef.setData(encodeTask) { (err) in
//            if let _err = err {
//                print("データ追加失敗",_err)
//            } else {
//                print("データ追加成功")
//            }
//        }
//    }
    
    //登録処理
    @IBAction func tapToRegister(_ sender: Any) {
        //firebaseに値を保存
        
        //遷移先に飛ばす
        let vc = HomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

  
}
