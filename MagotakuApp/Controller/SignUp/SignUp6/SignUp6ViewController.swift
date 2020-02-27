//
//  SignUp6ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp6ViewController: UIViewController {
    
    @IBOutlet weak var photoLabel: UILabel!
    let profileImage: UIImageView! = UIImageView()
    let tapRec: UITapGestureRecognizer! = UITapGestureRecognizer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "サービス利用者情報"
        
        
        profileImage.image = UIImage(named: "setting")
        profileImage.backgroundColor = UIColor(red: 99/255, green: 101/255, blue: 105/255, alpha: 1)
        
        self.view.addSubview(profileImage)
         
    }
    
    override func viewDidLayoutSubviews() {
        let photoLoc:CGFloat? = photoLabel.frame.origin.y
        //プロファイルイメージ用のUIImageViewを用意
        profileImage.frame = CGRect(x: UIScreen.main.bounds.size.width / 4, y: photoLoc! + 38, width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.width / 2)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }

    
    
    

   
   
}
