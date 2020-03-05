//
//  ReservationCell.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/05.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class ReservationCell: UITableViewCell {

    @IBOutlet weak var partnerImage: UIImageView!
    @IBOutlet weak var cell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        partnerImage.layer.cornerRadius = partnerImage.frame.width / 2
        
        cell.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 96)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
