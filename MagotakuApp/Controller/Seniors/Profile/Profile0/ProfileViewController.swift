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

    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var testTV: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "マイページ"
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        titleView.image = UIImage(systemName: "paperclip.circle.fill")
        self.navigationItem.titleView = titleView
        
        logoutBtn.layer.cornerRadius = logoutBtn.frame.height / 2
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
