//
//  SeniorUserCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/02.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation

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
    
}


