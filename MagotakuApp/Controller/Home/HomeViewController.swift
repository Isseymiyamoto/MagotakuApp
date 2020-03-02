//
//  HomeViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/29.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("a")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }



}
