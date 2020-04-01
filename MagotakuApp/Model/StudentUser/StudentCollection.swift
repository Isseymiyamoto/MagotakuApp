//
//  StudentCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/21.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class StudentUserCollection{
    //初回アクセスのタイミングでインスタンス作成
    static var shared = StudentUserCollection()
    
    let studentUseCase: StudentUseCase
    
    //テスト的に挿入
//    let reservation: ReservationUseCase
    
    //外部からの初期化を禁止する
    private init(){
        studentUseCase = StudentUseCase()
        //テスト的に挿入
//        reservation = ReservationUseCase()
    }
    
    //全体でのreservations
    private var allReservations: [Reservation] = []
    
    //プロフィールの取得
    func fetchProfile() -> Void{
        studentUseCase.fetchStudentUser()
    }
    
    //写真を保存する
    func saveImage(image:UIImage?, callback: @escaping ((String?) -> Void)) {
        studentUseCase.saveImage(image: image) { (imageName) in
            guard let imageName = imageName else {
                callback(nil)
                return
            }
            callback(imageName)
        }
    }
    
    func getImageRef(imageName: String) -> StorageReference? {
        return studentUseCase.getImageRef(imageName: imageName)
    }
    
    func editProfile(_ studentUser: StudentUser) {
        studentUseCase.editProfile(studentUser)
    }
    
    
    
    //学生側に表示するよう
    //すべてのデータを引っ張ってくる
//    private func allFetch(){
//        reservation.fetchAllReservation { (fetchReservations) in
//            guard let fetchReservations = fetchReservations else{
//                return
//            }
//            self.allReservations = self.sortReservationByUpdatedAt(reservations: fetchReservations)
//        }
//    }
//
//    private func sortReservationByUpdatedAt(reservations: [Reservation]) -> [Reservation]{
//        return reservations.sorted(by: {$0.updatedAt.dateValue() > $1.updatedAt.dateValue()})
//    }
//
//    //すべての予約数を管理(学生表示用)
//    func allReservationCount() -> Int{
//        return allReservations.count
//    }
}
