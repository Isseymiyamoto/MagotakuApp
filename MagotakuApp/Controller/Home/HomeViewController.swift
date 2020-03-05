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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ホーム"
     
        print(Auth.auth().currentUser!.uid)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//    }
    
    
    

}
