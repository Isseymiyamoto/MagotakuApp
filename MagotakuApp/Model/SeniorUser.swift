//
//  SeniorUser.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SeniorUser{
    //アカウントuid
    var id: String
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
    //サービス利用者電話
    var phoneNumber: String = ""
    //サービス利用者性格・趣味
    var CharaHob: String = ""
    //サービス利用者プロフィール写真
    var imageName: String = ""
    //緊急連絡先
    var emergencyPhoneNumber: String = ""
    //Timestamp
    var createdAt: Timestamp
    var updatedAt: Timestamp
    
    
    init(id:String) {
        self.id = id
//        self.sName = sName
//        self.aName = aName
//        self.sex = sex
//        self.bornDate = bornDate
//        self.addressNum = addressNum
//        self.address = address
//        self.phoneNumber = phoneNumber
//        self.CharaHob = CharaHob
//        self.imageName = imageName
//        self.emergencyPhoneNumber = emergencyPhoneNumber
        self.createdAt = Timestamp()
        self.updatedAt = Timestamp()
    }
}


