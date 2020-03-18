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
    DocumentIDを入れるためのid 識別子
    var id : String

//    アカウントのuid
    var uid : String = ""

//    学生氏名
    var name: String = ""

//    学生性別
    var sex : String = ""

//    学生誕生日
    var bornDate: String = ""

//    学生登録区域
    var locations: [Int]!

//    学生電話番号(利用者からの電話に答えられるもの)
    var phoneNum: String = ""

//    学生趣味・特技・得意なこと
    var hobby: String = ""

//    学生学校・学年・専攻
    var school: String = ""

//    学生プロフィール用写真
    var imageName: String
    
    var createdAt: Timestamp
    var updatedAt: Timestamp
    
    init(id:String) {
        self.id = id
        self.createdAt = Timestamp()
        self.updatedAt = Timestamp()
    }
}











