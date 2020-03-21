//
//  StudentCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/21.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation

class StudentUserCollection{
    //初回アクセスのタイミングでインスタンス作成
    static var shared = StudentUserCollection()
    
    let studentUseCase: StudentUseCase
    
    //外部からの初期化を禁止する
    private init(){
        studentUseCase = StudentUseCase()
    }
    
    //プロフィールの取得
    func fetchProfile() -> Void{
        studentUseCase.fetchStudentUser()
    }
}
