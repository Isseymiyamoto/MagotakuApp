//
//  DetailReservationCell.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/30.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class DetailReservationCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
