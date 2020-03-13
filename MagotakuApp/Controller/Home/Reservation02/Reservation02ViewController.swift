//
//  Reservation02ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/06.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class Reservation02ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //cellに入れる写真名の配列
    let cellImages:[String] = ["folder.fill.badge.minus", "paperplane", "tray.fill"]
    
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
        layout.itemSize = CGSize(width: x.width / 4, height: x.width / 4)
        layout.minimumLineSpacing = x.width / 10
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as! CustomCollectionCell
        cell.backgroundColor = .lightGray
        
//        if indexPath.count % 3 == 0{
//            cell.imageView.image = UIImage(systemName: cellImages[0])
//        }else if indexPath.count % 3 == 1{
//            cell.imageView.image = UIImage(systemName: cellImages[1])
//        }else{
//            cell.imageView.image = UIImage(systemName: cellImages[2])
//        }
//
        cell.imageView.frame = CGRect(x: cell.frame.width / 4, y: cell.frame.width / 4, width: cell.frame.width / 2 , height: cell.frame.width / 2)
        cell.imageView.image = UIImage(systemName: cellImages[indexPath.item % 3])
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        
        
        
    }
    
    
    
    @IBAction func tapToNext(_ sender: Any) {
        let vc = Reservation03ViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    

  

}
