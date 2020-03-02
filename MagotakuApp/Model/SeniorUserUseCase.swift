//
//  SeniorUserUseCase.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/02.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class SeniorUserUseCase {
    let db = Firestore.firestore()
    
    private func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。") //本番環境では使わない
        }
        return self.db.collection("seniorUsers").document(uid).collection("profile")
    }
    
    func createSeniorUserId() -> String {
        let id = self.getCollectionRef().document().documentID
        print("seniorUserIdは",id)
        return id
    }
    
    func addTask(_ seniorUser: SeniorUser){
        let documentRef = getCollectionRef().document(seniorUser.id)
        let encodeTask = try! Firestore.Encoder().encode(seniorUser)
        documentRef.setData(encodeTask) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
            }
        }
    }
    
}

