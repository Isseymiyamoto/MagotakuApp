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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var expectedPrice: UILabel!
    @IBOutlet weak var seniorImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        dateLabel.adjustsFontSizeToFitWidth = true
        expectedPrice.adjustsFontSizeToFitWidth = true
        timeLabel.adjustsFontSizeToFitWidth = true
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black.cgColor
    }

}
