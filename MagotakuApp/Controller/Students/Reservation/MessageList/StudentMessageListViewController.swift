//
//  StudentMessageListViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/04/03.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class StudentMessageListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setZeroReservation()
    }

    
    func setZeroReservation(){
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        self.view.addSubview(view)
        //「確定している予約 0件」表示用のラベル
        let zeroLable = UILabel()
        zeroLable.text = "メッセージ 0件"
        zeroLable.font = UIFont.boldSystemFont(ofSize: 16)
        zeroLable.frame = CGRect(x: 24, y: 24, width: UIScreen.main.bounds.width - 16, height: 22)
        view.addSubview(zeroLable)
        //予約を促す ラベル
        let stimulatorLabel = UILabel()
        stimulatorLabel.text = "予約リストからメッセージを送ってみましょう"
        stimulatorLabel.font = UIFont.systemFont(ofSize: 14)
        stimulatorLabel.frame = CGRect(x: 24, y: 54, width: UIScreen.main.bounds.width - 16, height: 22)
        view.addSubview(stimulatorLabel)
        //予約を行うためのボタン
        let reservationBtn = UIButton(type: .system)
        reservationBtn.setTitle("新規予約を行う", for: .normal)
        reservationBtn.setTitleColor(.white, for: .normal)
        reservationBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        reservationBtn.titleLabel?.textAlignment = .center
        reservationBtn.backgroundColor = UIColor(red: 94/255, green: 123/255, blue: 211/255, alpha: 1)
        reservationBtn.frame = CGRect(x: 24, y: 88, width: 240, height: 48)
        reservationBtn.layer.cornerRadius = 6.0
        view.addSubview(reservationBtn)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
