//
//  PartSeniorProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/04/03.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class PartSeniorProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    let titleLabels:[String] = ["性別", "年齢", "趣味", "評価・レビュー"]
    let imageLists:[String] = ["person.crop.rectangle.fill", "calendar.circle.fill", "bookmark", "star.fill"]
    
    @IBOutlet weak var tableView: UITableView!
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "詳細プロフィール"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = self.view.bounds
        tableView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tableView再描画
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleLabels.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = titleLabels[indexPath.section]
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            cell.imageView?.image = UIImage(systemName: imageLists[indexPath.section])
            //セル選択時にハイライトさせない
            cell.selectionStyle = .none
            return cell
        default:
            let cell1 = UITableViewCell(style: .value1, reuseIdentifier: "cell1")
            if indexPath.section == 3{
                cell1.textLabel?.text = "今後実装します"
            }else{
                cell1.textLabel?.text = "これでどうだ"
            }
            return cell1
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }

    //headerViewを設置
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView()
            view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
            imageView.backgroundColor = UIColor(red: 99/255, green: 101/255, blue: 105/255, alpha: 1)
            imageView.frame = CGRect(x: (UIScreen.main.bounds.width / 8) * 3, y: (240 - UIScreen.main.bounds.width / 4) / 2, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
            imageView.layer.cornerRadius = UIScreen.main.bounds.width / 8
            view.addSubview(imageView)
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 240
        default:
            return 0
        }
    }

    

}
