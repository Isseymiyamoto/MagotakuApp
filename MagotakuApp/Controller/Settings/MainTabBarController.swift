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
        tabBar.tintColor = UIColor.white
        
        let firstVC = MainNavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let secondVC = MainNavigationController(rootViewController: ReservationViewController())
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        let thirdVC = MainNavigationController(rootViewController: ProfileViewController())
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        
        
    }
    

  

}
