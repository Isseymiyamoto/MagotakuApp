//
//  StudentReservationViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Parchment

class StudentReservationViewController: UIViewController {

    var pagingVC = PagingViewController()

        override func viewDidLoad() {
            super.viewDidLoad()

            //上タブの設定
            let firstVC = ReservationListViewController()
            let secondVC = SignUp2ViewController()
            
            //各タブ名の設定
            firstVC.title = "確定済み予約一覧"
            secondVC.title = "メッセージ"

            pagingVC = PagingViewController(viewControllers: [firstVC, secondVC])
            pagingVC.menuItemSize = PagingMenuItemSize.fixed(width: UIScreen.main.bounds.width / 2, height: 60)

            addChild(pagingVC)
            view.addSubview(pagingVC.view)
            pagingVC.didMove(toParent: self)
            pagingVC.view.translatesAutoresizingMaskIntoConstraints = false
             
        }

        override func viewWillAppear(_ animated: Bool) {
            navigationController?.navigationBar.isHidden = true
        }
        
        override func viewDidLayoutSubviews() {
            let bottomM = self.view.safeAreaInsets.top
            view.constrainToEdges(pagingVC.view, topPadding: bottomM)
        }

        
        
        


   
}


