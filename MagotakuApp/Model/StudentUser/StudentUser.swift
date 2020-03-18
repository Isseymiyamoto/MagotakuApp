//
//  StudentUser.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/18.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class StudentUser: Codable{
    //識別子
    var id: String
    ////アカウントuid
    var uid: String = ""
    //サービス利用者名
    var sName: String = ""
    //アプリケーション使用者氏名
    var aName: String = ""
    //サービス利用者性別
    var sex: String = ""
    //サービス利用者誕生日
    var bornDate: String = ""
    //サービス利用者郵便番号
    var addressNum: String = ""
    //サービス利用者住所
    var address: String = ""
    //サービス利用者電話userInfo    MagotakuApp.SeniorUser?    nil    none
    var phoneNumber: String = ""
    //サービス利用者性格・趣味
    var CharaHob: String = ""
    //サービス利用者プロフィール写真
    var imageName: String = ""
//    var userImage: UIImage?
    //緊急連絡先
    var emergencyPhoneNumber: String = ""
    //Timestamp
    var createdAt: Timestamp
    var updatedAt: Timestamp
    
//    static var shared = SeniorUser(id: "uid")
    
    init(id:String) {
        self.id = id
        self.createdAt = Timestamp()
        self.updatedAt = Timestamp()
    }
}


