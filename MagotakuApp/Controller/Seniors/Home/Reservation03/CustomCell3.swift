//
//  CustomCell3.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/17.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomCell3: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .gray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
