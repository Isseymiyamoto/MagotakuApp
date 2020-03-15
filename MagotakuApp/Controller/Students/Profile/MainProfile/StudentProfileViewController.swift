//
//  StudentProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StudentProfileViewController: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutBtn.layer.cornerRadius = 24.0
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            // 強制的に現在の表示している vc を変更する
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()

            let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = vc
        } catch {
            print("error:",error.localizedDescription)
        }
    }
    


}
