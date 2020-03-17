//
//  ReservationCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseStorage

class ReservationCollection{
    //初回アクセスのタイミングでインスタンスを生成
    static var shared = ReservationCollection()

    let reservationUseCase: ReservationUseCase

    //外部からの初期化を禁止
    private init(){
        reservationUseCase = ReservationUseCase()
    }

    func createReservation() ->  Reservation {
        let id = reservationUseCase.createReservationId()
        return Reservation(id: id)
    }
    
    func addReservation(_ reservation: Reservation){
        reservationUseCase.addReservation(reservation)
    }

    
}


