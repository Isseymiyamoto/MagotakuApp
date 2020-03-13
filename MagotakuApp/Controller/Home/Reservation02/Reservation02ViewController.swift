//
//  Reservation02ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/06.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class Reservation02ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
        
    }
    
    
    

    

  

}
