//
//  ColumnFlowLayout.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/12.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else{ return }
        self.itemSize = CGSize(width: cv.bounds.inset(by: cv.layoutMargins).size.width, height: 120.0)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
    }
    
    

}
