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
import FirebaseUI

class SeniorUserUseCase {
    let db = Firestore.firestore()
    
    let storage = Storage.storage()
    
    private func getCollectionRef () -> CollectionReference {
        guard (Auth.auth().currentUser?.uid) != nil else {
            fatalError ("Uidを取得出来ませんでした。") //本番環境では使わない
        }
        return self.db.collection("seniorUsers")
    }
    
    //documentIDをidとしてSeniorUserクラスのイニシャライズ
    func createSeniorUserId() -> String {
        let id = self.getCollectionRef().document().documentID
        print("seniorUserIdは",id)
        return id
    }
    
    
    //FirestoreにSeniorUserのProfile登録 (新規登録時に利用)
    func addTask(_ seniorUser: SeniorUser){
        let documentRef = getCollectionRef().document(seniorUser.uid)
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
            print("このuidは学生じゃの")
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
            let imageData = image.jpegData(compressionQuality: 0.1),
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
    

    func fetchSeniorUser() -> Void{
        let collectionRef = getCollectionRef()
        collectionRef.document(Auth.auth().currentUser!.uid).getDocument { (document, err) in
            if document?.data() != nil {
                let userInfo = try? Firestore.Decoder().decode(SeniorUser.self, from: document!.data()!)
            print("userInfo: \(userInfo!)")
            seniorProfile = userInfo!
                
            //ログイン遷移
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                    return
            }
            let vc = MainTabBarController()
            sceneDelegate.window?.rootViewController = vc
                
           } else {
               print("Document does not exist")
           }
        }

    }
    
    
    func loginCheck(callback: @escaping ((Bool) -> Void)){
        let collectionRef = getCollectionRef()
        var result: Bool = false
        print(Auth.auth().currentUser!.uid)
        collectionRef.document(Auth.auth().currentUser!.uid).getDocument { (document, err) in
            if document?.data() != nil{
                result = true
                print("正常な方が読まれています")
            }else{
                print(err as Any)
                print("エラーの方が読まれてます")
            }
            callback(result)
        }
    }

    
    
    
    
}

