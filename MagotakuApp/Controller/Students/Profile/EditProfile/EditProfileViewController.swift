//
//  EditProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "基本情報"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            return cell
        default:
            let cell1 = UITableViewCell(style: .value1, reuseIdentifier: "cell1")
            return cell1
        }
        
    }

}
