//
//  Reservation02ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/06.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class Reservation02ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //タップされた箇所一時的に保存する
    var selectBool : [Bool] = [false, false, false, false, false, false]
    //最終的にtrueだったindex番号のみを格納するための配列
    var finalResults = [Int]()
    
    //cellに入れる写真名の配列
    let cellImages:[String] = ["listen", "ITLesson", "houseWork", "walking", "talking", "others"]
    
    @IBOutlet weak var nextBtn: UIButton!
    
    //スクリーンサイズ取得用
    let x = UIScreen.main.bounds
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBarのタイトル設定
        self.title = "お手伝い内容を選ぶ"
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        

        //Xibファイルの設定
        let nib = UINib(nibName: "CustomCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionCell")
        
        
        nextBtn.layer.cornerRadius = 24.0
        
        //レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (x.width / 5) * 2, height: self.view.bounds.height / 5)
        layout.minimumLineSpacing = x.width / 10
        layout.sectionInset = UIEdgeInsets(top: x.width / 20, left: x.width / 20, bottom: x.width / 20, right: x.width / 20)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as! CustomCollectionCell
        let helpContents = ["傾聴", "ITレッスン", "家事", "散歩", "おしゃべり", "その他"]
        cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        cell.layer.cornerRadius = 6.0
        cell.imageView.frame = CGRect(x: cell.frame.width / 4, y: cell.frame.width / 4, width: cell.frame.width / 2 , height: cell.frame.width / 2)
        cell.imageView.image = UIImage(named: cellImages[indexPath.item])
        cell.serviceName.text = helpContents[indexPath.item]
        cell.serviceName.font = UIFont.boldSystemFont(ofSize: 16)
        cell.serviceName.textAlignment = .center
        cell.serviceName.frame = CGRect(x: 0, y: cell.bounds.height - 32, width: cell.bounds.width, height: 22)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
        
        let cell  = collectionView.cellForItem(at: indexPath) as! CustomCollectionCell
        
        if selectBool[indexPath.item]{
            cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            cell.checkBtn.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            selectBool[indexPath.item] = false
        }else{
            cell.checkBtn.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            cell.backgroundColor = .lightGray
            selectBool[indexPath.item] = true
        }
        
        
//        if cell.checkd{
//            //check画像を消す
//            cell.backgroundColor = .lightGray
//            cell.checkBtn.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
//            cell.checkBtn.imageView?.image = UIImage(systemName: "square")
//            cell.checkd = false
//
//        }else{
//            cell.checkBtn.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
//            cell.checkBtn.imageView?.image = UIImage(systemName: "checkmark.square")
//            cell.backgroundColor = .systemPink
//            cell.checkd = true
//        }
        
        
        
    }
    
    
    
    @IBAction func tapToNext(_ sender: Any) {
//        print(selectBool)
        for i in 1 ..< selectBool.count{
            if selectBool[i]{
                finalResults.append(i)
            }else{
                continue
            }
        }
        print(finalResults)
        reservation.helpContents = finalResults
        let vc = Reservation03ViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    

  

}
