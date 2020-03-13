//
//  CustomCollectionCell.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/12.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //選択されているか否か
    var checkd = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.imageView.frame = CGRect(x: self.view.frame.width / 4, y: self.view.frame.width / 4, width: self.view.frame.width / 2 , height: self.view.frame.width / 2)
        
    }
    
    

}
