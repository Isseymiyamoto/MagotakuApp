//
//  Reservation.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/06.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Reservation: Codable{
    //識別子
    var id: String
    //シニア側uid
    var seUid: String
    //学生側uid
    var stUid: String = ""
    //予約成立可否の識別子(0が未成立、1が成立、2がキャンセル)
    var reservationNum: Int = 0
    //訪問希望日時
    //    var visitDate: NSDate
    //お手伝い内容
    
    //Timestamp
    var createdAt: Timestamp
    var updatedAt: Timestamp
    
//    static var shared = SeniorUser(id: "uid")
    
    init(id:String, seUid:String) {
        self.id = id
        self.seUid = seUid
        self.createdAt = Timestamp()
        self.updatedAt = Timestamp()
    }
}



