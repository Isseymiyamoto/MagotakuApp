//
//  MainTabBarController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/03.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景色
        tabBar.barTintColor = UIColor.white
        // アイテムの色
        tabBar.tintColor = UIColor.black
        
        let firstVC = MainNavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem = UITabBarItem(title: "ホーム", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let secondVC = MainNavigationController(rootViewController: ReservationViewController())
        secondVC.tabBarItem = UITabBarItem(title: "予約一覧", image: UIImage(systemName: "tray.fill"), tag: 1)
        
        let thirdVC = MainNavigationController(rootViewController: ProfileViewController())
        thirdVC.tabBarItem = UITabBarItem(title: "マイページ", image: UIImage(systemName: "person.fill"), tag: 2)
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
    }
    

  

}
