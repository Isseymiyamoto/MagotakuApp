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
import FirebaseStorage

class SeniorUserUseCase {
    let db = Firestore.firestore()
    
    let storage = Storage.storage()
    
    private func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。") //本番環境では使わない
        }
        return self.db.collection("seniorUsers").document(uid).collection("profile")
    }
    
    //documentIDをidとしてSeniorUserクラスのイニシャライズ
    func createSeniorUserId() -> String {
        let id = self.getCollectionRef().document().documentID
        print("seniorUserIdは",id)
        return id
    }
    
    
    //FirestoreにSeniorUserのProfile登録 (新規登録時に利用)
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
    
    func getStorageReference() -> StorageReference? {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        return storage.reference().child("seniorUsers").child(uid)
    }

    func getImageRef(imageName: String) -> StorageReference? {
        return getStorageReference()?.child(imageName)
    }

    func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)) {
        // オプショナルを外したり、 iamgeData を作成
        guard let image = image,
            let imageData = image.jpegData(compressionQuality: 0.5),
            let imageRef = getStorageReference() else {
            callback(nil)
            return
        }

        // 保存に必要なものを作成
        let imageName = NSUUID().uuidString
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        // 保存する
        let ref = imageRef.child(imageName)
        ref.putData(imageData, metadata: metaData) { (metaData, error) in
            guard let _ = metaData else {
                print("画像の保存に失敗しました。。。😭")
                callback(nil)
                return
            }
            print("画像の保存が成功した！！！！！！")
            callback(imageName)
        }
    }
    
    //データ取得
//    func fetchSeniorUser(callback: @escaping ([SeniorUser]?) -> Void){
//        let collectionRef = getCollectionRef()
//        collectionRef.getDocuments(source: .default) { (snapshot, err) in
//            guard err == nil, let snapshot = snapshot, !snapshot.isEmpty else{
//                print("データ取得失敗", err.debugDescription)
//                return
//            }
//            print("データ取得成功")
//            let SeniorUserInfo = snapshot.documents.compactMap { (snapshot) in
//                return try? Firestore.Decoder().decode(SeniorUser.self, from: snapshot.data())
//            }
//            callback(SeniorUserInfo)
//        }
//    }
    
    
//
    func fetchSeniorUser() -> SeniorUser{
        let collectionRef = getCollectionRef()
        var userInfo: SeniorUser!
        collectionRef.document().getDocument { (snapshot, err) in
            guard err == nil, let snapshot = snapshot else{
                print("データ取得失敗", err.debugDescription)
                return
            }
            print("データ取得成功")
            userInfo = try? Firestore.Decoder().decode(SeniorUser.self, from: snapshot.data()!)
        }
        return userInfo
    }
//

    
    
    
    
}

