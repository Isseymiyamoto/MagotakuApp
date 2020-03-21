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
}
