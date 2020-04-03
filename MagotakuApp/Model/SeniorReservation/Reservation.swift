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
    var seUid: String = ""
    //シニア側imageURL
    var seniorImage: String = ""
    //学生側uid
    var stUid: String = ""
    //学生側imageURL
    var studentImage: String = ""
    //予約成立可否の識別子(0が未成立、1が成立、2がキャンセル)
    var reservationNum: Int = 0
    //訪問希望日
    var visitDate: String = ""
    //訪問希望開始時間
    var visitTime : String = ""
    //希望時間数
    var vistHour : String = ""
    //お手伝い内容
    var helpContents: [Int]?
    //予想金額
    var ExpectedPrice: String = ""
    //確定金額
    var price: String = ""
    
    //Timestamp
    var createdAt: Timestamp
    var updatedAt: Timestamp
    
    init(id:String) {
        self.id = id
//        self.seUid = seUid
        self.createdAt = Timestamp()
        self.updatedAt = Timestamp()
    }
}




