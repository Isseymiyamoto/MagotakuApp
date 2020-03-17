//
//  Reservation03ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/13.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase

var reservation = ReservationCollection.shared.createReservation()

class Reservation03ViewController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "確認画面"
        
        //ログインしてるか確認
        if let user = Auth.auth().currentUser{
            reservation.seUid = user.uid
        }
        
        
        registerBtn.layer.cornerRadius = 24.0
    }

    
    @IBAction func tapToRegister(_ sender: Any) {
        //Firestoreに予約情報送信
        ReservationCollection.shared.addReservation(reservation)
        
        //予約一覧画面に飛ばす
//        let vc = ReservationViewController()
//        let backButtonItem =  UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backButtonItem
//        navigationController?.pushViewController(vc, animated: true)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else{
                return
        }
        let vc = MainTabBarController()
        sceneDelegate.window?.rootViewController = vc
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
