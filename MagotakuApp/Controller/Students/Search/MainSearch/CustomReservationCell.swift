//
//  CustomReservationCell.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/24.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomReservationCell: UICollectionViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        dateLabel.adjustsFontSizeToFitWidth = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }

}
