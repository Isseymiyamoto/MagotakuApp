//
//  SeniorUserCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/02.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit

class SeniorUserCollection{
    //初回アクセスのタイミングでインスタンスを生成
    static var shared = SeniorUserCollection()

    let seniorUserUseCase: SeniorUserUseCase

    //外部からの初期化を禁止
    private init(){
        seniorUserUseCase = SeniorUserUseCase()
    }
    
    func createSeniorUser() -> SeniorUser {
        let id = seniorUserUseCase.createSeniorUserId()
        return SeniorUser(id: id)
    }
    
    func addTask(_ seniorUser: SeniorUser) {
        seniorUserUseCase.addTask(seniorUser)
    }
    
    func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)) {
        seniorUserUseCase.saveImage(image: image) { (imageName) in
            guard let imageName = imageName else {
                callback(nil)
                return
            }
            callback(imageName)
        }
    }
    
    func getImageRef(imageName: String) -> StorageReference? {
        return seniorUserUseCase.getImageRef(imageName: imageName)
    }
    
    func fetchProfile() -> Void{
        seniorUserUseCase.fetchSeniorUser()
    }
    
    func loginCheck(callback: @escaping ((Bool) -> Void)){
        var boolResult = false
        seniorUserUseCase.loginCheck { (result) in
            print(result)
            if result == true{
                boolResult = true
            }
            callback(boolResult)
        }
    }
    
    
}


