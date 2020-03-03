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
        tabBar.barTintColor = UIColor.black
        
        // アイテムの色
        tabBar.tintColor = UIColor.white
        
        let firstViewController = MainNavigationController(rootViewController: HomeViewController())
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let secondViewController = MainNavigationController(rootViewController: ReservationViewController())
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        let thirdViewController = MainNavigationController(rootViewController: ProfileViewController())
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        self.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        
    }
    

  

}
