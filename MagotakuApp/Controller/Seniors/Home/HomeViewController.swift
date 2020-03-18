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

        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        titleView.image = UIImage(systemName: "paperclip.circle.fill")
        self.navigationItem.titleView = titleView
     
        reservationBtn.layer.cornerRadius = 30.0
        reservationBtn.backgroundColor = UIColor(red: 244/255, green: 176/255, blue: 131/255, alpha: 1)
        

        
        SeniorUserCollection.shared.fetchProfile()
        
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        
    }
    
    override func viewDidLayoutSubviews() {
        //gradinet-layerカラーの作成
                let a:CGColor = UIColor(red: 41/255, green: 162/255, blue: 226/255, alpha: 1).cgColor
                let b:CGColor = UIColor(red: 65/255, green: 132/255, blue: 190/255, alpha: 1).cgColor
                let gradientLayer = CAGradientLayer()
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                gradientLayer.frame = (navigationController?.navigationBar.frame)!
//                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 120)
                gradientLayer.colors = [a, b]
                self.view.layer.insertSublayer(gradientLayer, at: 0)
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
