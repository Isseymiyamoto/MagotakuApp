//
//  ProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/03.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "マイページ"
        
    }

    
    @IBAction func logout(_ sender: Any) {
        do {
                try Auth.auth().signOut()
                // 強制的に現在の表示している vc を変更する
                let vc = ViewController()
                let sceneDelegate = view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = vc
            } catch {
                print("error:",error.localizedDescription)
            }
        
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
