//
//  ReservationCollection.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import FirebaseStorage

protocol ReservationCollectionDelegate: class {
    func saved()
    func loaded()
}

class ReservationCollection{
    //初回アクセスのタイミングでインスタンスを生成
    static var shared = ReservationCollection()

    let reservationUseCase: ReservationUseCase

    //外部からの初期化を禁止
    private init(){
        reservationUseCase = ReservationUseCase()
        load()
    }
    
    //seniro個人向けのreservations
    private var personalReservations: [Reservation] = []
    
    //全体でのreservations
//    private var allReservations: [Reservation] = []
    
    weak var delegate: ReservationCollectionDelegate? = nil

    func createReservation() ->  Reservation {
        let id = reservationUseCase.createReservationId()
        return Reservation(id: id)
    }
    
    //シニア側の個人の予約数を管理
    func reservationCount() -> Int{
        return personalReservations.count
    }
    
    func addReservation(_ reservation: Reservation){
        reservationUseCase.addReservation(reservation)
        personalReservations.append(reservation)
        save()
    }
    
    func getReservation (at: Int) -> Reservation{
        return personalReservations[at]
    }
    
    private func save() {
        personalReservations = sortReservationByUpdatedAt(reservations: personalReservations)
        delegate?.saved()
    }
    
    private func load(){
        reservationUseCase.fetchReservationDocuments { (fetchReservations) in
            guard let fetchReservations = fetchReservations else{
                self.save()
                return
            }
            self.personalReservations = self.sortReservationByUpdatedAt(reservations: fetchReservations)
            self.delegate?.loaded()
        }
    }
    
    private func sortReservationByUpdatedAt(reservations: [Reservation]) -> [Reservation]{
        return reservations.sorted(by: {$0.updatedAt.dateValue() > $1.updatedAt.dateValue()})
    }
    
    func resetData(){
        personalReservations = []
    }
    
    
    
    
}


