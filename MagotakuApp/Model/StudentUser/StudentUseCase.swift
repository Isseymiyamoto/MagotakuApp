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
        let collectionRef = getCollectionRef()
        collectionRef.document(Auth.auth().currentUser!.uid).getDocument { (document, err) in
            if document?.data() != nil{
                let userInfo = try? Firestore.Decoder().decode(StudentUser.self, from: document!.data()!)
                print("userInfo:\(userInfo!)")
                studentProfile = userInfo!
            }else{
                print("君のデータはありませんね。(StudentUseCase/fetchStudentUser)")
            }
        }
        
    }
    
    
}

