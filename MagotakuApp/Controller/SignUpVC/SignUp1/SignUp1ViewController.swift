//
//  SignUp1ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "利用者情報"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
