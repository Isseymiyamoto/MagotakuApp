//
//  LoginStudentViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/14.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class LoginStudentViewController: UIViewController {
    
    let mailTF: CustomTextField! = CustomTextField()
    let passwordTF: CustomTextField! = CustomTextField()
    @IBOutlet weak var loginBtn: UIButton!
    var bottomMargin:CGFloat? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学生用ログイン"
    }

    override func viewWillAppear(_ animated: Bool) {
        //navigationbarを表示する
        navigationController?.navigationBar.isHidden = false
    }

    
}
