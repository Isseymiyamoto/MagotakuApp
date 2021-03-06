//
//  StudentReservationCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/24.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseStorage
import PKHUD

protocol StudentReservationCollectionDelegate: class {
    func saved()
    func loaded()
}

class StudentReservationCollection{
    
    //初回アクセスのタイミングでインスタンスを生成
    static var shared = StudentReservationCollection()

    let reservationUseCase: ReservationUseCase

    //外部からの初期化を禁止
    private init(){
        reservationUseCase = ReservationUseCase()
    }
    
    weak var delegate: StudentReservationCollectionDelegate? = nil
    
    //全体でのreservations
    private var allReservations: [Reservation] = []
    
    //ユーザーの訪問が決定した予約を入れるための配列
    private var personalReservation: [Reservation] = []
    
    //学生側に表示するよう
    //すべてのデータを引っ張ってくる
    func allFetch(){
        print("allFetchスタート")
        reservationUseCase.fetchAllReservation { (fetchReservations) in
            guard let fetchReservations = fetchReservations else{
                //test的に変更
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                        return
                }
                let vc = StudentTabBarController()
                sceneDelegate.window?.rootViewController = vc
                //ここまで
                
                return
            }
            self.allReservations = self.sortReservationByUpdatedAt(reservations: fetchReservations)
            
            //ここでfetch後に画面遷移している
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                    return
            }
            let vc = StudentTabBarController()
            sceneDelegate.window?.rootViewController = vc
            
            
            print("allFetchドーン")
        }
    }
    
    //すべての予約数を管理(学生表示用)
    func allReservationCount() -> Int{
        return allReservations.count
    }
    
    private func sortReservationByUpdatedAt(reservations: [Reservation]) -> [Reservation]{
        return reservations.sorted(by: {$0.updatedAt.dateValue() > $1.updatedAt.dateValue()})
    }
    
    //すべての予約にアクセスする際に用いる
    func getReservation (at: Int) -> Reservation{
        return allReservations[at]
    }
    
    //個別の決定された予約にアクセスする際に用いる
    func getPersonalReservation(at: Int) -> Reservation{
        return personalReservation[at]
    }
    
    //学生側にてシニア側の画像を取得する
    func getImageRef(uid: String, imageName: String) -> StorageReference? {
        return reservationUseCase.getSeniorImageRef(uid: uid, imageName: imageName)
    }
    
    //訪問を希望するreservationをupdateする
    func finishReservation(_ reservation: Reservation, deleteNum: Int){
        reservationUseCase.finishReservation(reservation) { (number) in
            if number == 0{
                //エラー
                HUD.flash(.error, delay: 1)
                
            }else if number == 1{
                self.personalReservation.append(self.allReservations[deleteNum])
                self.allReservations.remove(at: deleteNum)
                //成功
                HUD.flash(.success, delay: 1) { (_) in
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                            return
                    }
                    let vc = StudentTabBarController()
                    sceneDelegate.window?.rootViewController = vc
                }
                
            }
        }
    }
    
    private func save() {
        personalReservation = sortReservationByUpdatedAt(reservations: personalReservation)
        delegate?.saved()
    }
    
    //成立しているを予約を取得する
    func fetchPersonalReservation(){
        reservationUseCase.studentPersonalReservation { (fetchReservations) in
            guard let fetchReservations = fetchReservations else{
                return
            }
            self.personalReservation = self.sortReservationByUpdatedAt(reservations: fetchReservations)
            self.delegate?.loaded()
        }
    }
    
    //成立している予約の件数を取得する
    func getPersonalReservationCount() -> Int{
        return personalReservation.count
    }
   
    
    
}
