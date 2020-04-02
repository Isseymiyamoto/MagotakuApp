//
//  ReservationUseCase.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage

class ReservationUseCase {
    
    //firestore初期化
    let db = Firestore.firestore()
    //firestorage初期化
    let storage = Storage.storage()
    
    private func getCollectionRef () -> CollectionReference {
        return self.db.collection("Reservation")
    }

    //documentIDをidとしてReservationクラスのイニシャライズ
    func createReservationId() -> String {
        let id = self.getCollectionRef().document().documentID
        print("reservationIdは",id)
        return id
    }


    //FirestoreにSeniorUserのProfile登録 (新規登録時に利用)
    func addReservation(_ reservation: Reservation){
        let documentRef = getCollectionRef().document(reservation.id)
        let encodeTask = try! Firestore.Encoder().encode(reservation)
        documentRef.setData(encodeTask) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
                
            }
        }
    }
    
    //シニア側において、自分の予約を取得する
    func fetchReservationDocuments(callback: @escaping ([Reservation]?) -> Void){
        let collectionRef = getCollectionRef()
        collectionRef.whereField("seUid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments(source: .default) { (snapshot, err) in
            guard err == nil, let snapshot = snapshot,!snapshot.isEmpty else {
                print("データ取得失敗",err.debugDescription)
                callback(nil)
                return
            }
            
            print("データ取得成功")
            let reservations = snapshot.documents.compactMap { snapshot in
                return try? Firestore.Decoder().decode(Reservation.self, from: snapshot.data())
            }
            print(reservations)
            callback(reservations)
        }
    }
    
    //すべての予約を取得する
    func fetchAllReservation(callback: @escaping ([Reservation]?) -> Void){
        let collectionRef = getCollectionRef()
        collectionRef.getDocuments(source: .default, completion: { (snapshot, err) in
            guard let snapshot = snapshot, err == nil, !snapshot.isEmpty else{
                print("データ取得失敗(reservationUseCase/fetchAllReservation)", err.debugDescription)
                callback(nil)
                return
            }
             print("データ取得成功(reservationUseCase/fetchAllReservation)")
            let reservations = snapshot.documents.compactMap{ snapshot in
                return try? Firestore.Decoder().decode(Reservation.self, from: snapshot.data())
            }
            print(reservations)
            callback(reservations)
        })
    }
    
    //学生側にてシニア側の画像を取得する
    func getImageRef(uid: String, imageName: String) -> StorageReference? {
        return storage.reference().child("seniorUsers").child(uid).child(imageName)
    }
    
    //学生側にて、予約を完了させる処理をする
    func finishReservation(_ reservation: Reservation){
        let documentRef = getCollectionRef().document(reservation.id)
        let encodeTask = try! Firestore.Encoder().encode(reservation)
        documentRef.setData(encodeTask) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
                
            }
        }
    }
    
    //学生側にて個別のプロフィールを取得する
//    func fetchPersonalSenior(uid: String, callback: @escaping([SeniorUser]?) -> Void ){
//
//        let collectionRef = db.collection("seniorUsers")
//        collectionRef.document(uid).getDocument { (document, err) in
//            if document?.data() != nil{
//                let userInfo = try? Firestore.Decoder.decode(SeniorUser.self, from: document!.data()!)
//            }
//        }
//    }
    
    
    
}
