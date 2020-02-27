//
//  SignUp5ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp5ViewController: UIViewController {
    
    @IBOutlet weak var hobbyTV: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationbarのタイトル設定
        self.title = "サービス利用者情報"
        
        hobbyTV.layer.cornerRadius = 6.0
        
        nextBtn.layer.cornerRadius = 6.0
        
        
    }


 
}
