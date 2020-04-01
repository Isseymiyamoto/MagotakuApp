//
//  StudentUseCase.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/18.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

//まだ関数部分は未着手ですよ

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI


class StudentUseCase{
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    //学生情報が格納されている場所のpathを取得
    private func getCollectionRef() -> CollectionReference{
        guard (Auth.auth().currentUser?.uid) != nil else{
            fatalError("uidを取得できませんでした")
        }
        return self.db.collection("studentUsers")
    }
    
    //dbに格納されている学生情報を取得
    func fetchStudentUser() -> Void{
        print("fetchStudentUser開始ですよ")
        let collectionRef = getCollectionRef()
        collectionRef.document(Auth.auth().currentUser!.uid).getDocument { (document, err) in
            if document?.data() != nil{
                
                //ひたすら代入する
                studentProfile.uid = document!.data()!["uid"]! as! String
                studentProfile.name = document!.data()!["name"]! as! String
                studentProfile.sex = document!.data()!["sex"]! as! String
                studentProfile.age = document!.data()!["age"]! as! String
                studentProfile.phoneNum = document!.data()!["phoneNum"]! as! String
                studentProfile.address = document!.data()!["address"]! as! String
                studentProfile.school = document!.data()!["school"]! as! String
                studentProfile.hobby = document!.data()!["hobby"]! as! String
                //学生側のイメージが格納されているかを確認する
                if !(document!.data()!["imageName"]! as! String).isEmpty{
                    print("空じゃないよ")
                    studentProfile.imageName = document!.data()!["imageName"]! as? String
                }else{
                    print("空だねえ")
//                    print(studentProfile.imageName)
                }
                
                //test的においてみる
                StudentReservationCollection.shared.allFetch()
                               
                print("これにてfetchStudentUser終了ですよ")
            }else{
                print("君のデータはありませんね。(StudentUseCase/fetchStudentUser)")
            }
        }
        
    }
    
    //学生側写真登録用function
    func getStorageReference() -> StorageReference? {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        return storage.reference().child("studentUsers").child(uid)
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
    
    //プロフィール編集時に使用するメソッド
    func editProfile(_ studentUser: StudentUser){
        let documentRef = getCollectionRef().document(studentUser.uid)
        let encodeTask = try! Firestore.Encoder().encode(studentUser)
        documentRef.setData(encodeTask){ (err) in
            if let err = err{
                print("編集データ追加失敗", err)
            } else{
                print("編集データ追加成功")
            }
        }
    }
    
    
}

