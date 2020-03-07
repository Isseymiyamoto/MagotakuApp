//
//  Reservation00ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/07.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class Reservation00ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //tableViewに使用する値
    private let sections: [[String]] = [
        ["訪問希望日"],
        ["開始時間", "終了時間"]
    ]

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBarのタイトル設定
        self.title = "訪問希望日を選ぶ"
        
        //プロトコルの設定
        tableView.delegate = self
        tableView.dataSource = self

        
    }

    //sectionの中に何個セル(row)が入るのか
    //[section]のsectionは引数sectionを使用しているだけ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    
    //セルを構築する際に呼ばれるメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = sections[indexPath.section][indexPath.row]
        return cell
    }
    
    //全体としてのセクション数は幾つなのか
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let title = sections[section].first{
            return String(title)
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
  

}
