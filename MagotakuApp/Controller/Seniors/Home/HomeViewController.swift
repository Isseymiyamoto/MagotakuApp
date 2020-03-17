//
//  HomeViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/29.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var reservationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "ホーム"
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        titleView.image = UIImage(systemName: "paperclip.circle.fill")
        self.navigationItem.titleView = titleView
     
        reservationBtn.layer.cornerRadius = 30.0
        
//        SeniorUserCollection.shared.fetchData()
        
        profile = SeniorUserCollection.shared.fetchProfile()
        
    }
    
    //新規予約1に飛ばす
    @IBAction func takeReserve(_ sender: Any) {
        let vc = Reservation00ViewController()
        //戻るボタンの設定
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    

    
    
    

}
