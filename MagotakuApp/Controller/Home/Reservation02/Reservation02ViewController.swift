//
//  Reservation02ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/06.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class Reservation02ViewController: UIViewController {

    //test用の変数
    var selectedDate: [Int]!
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBarのタイトル設定
        self.title = "お手伝い内容を選ぶ"

        var testString: String!
        testString = "選択日時：\(String(test[0]))年\(String(test[1]))月\(String(test[2]))日"
        testLabel.text = testString
        
    }


  

}
