//
//  CustomCellTableViewCell.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/10.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var customTF: UITextField!
    
    // ピッカー設定
    var datePicker = UIDatePicker()

    override func awakeFromNib() {
        super.awakeFromNib()
            datePicker.timeZone = NSTimeZone.local
            datePicker.locale = Locale(identifier: "ja") //日本語に変更
            datePicker.datePickerMode = UIDatePicker.Mode.time//形式を指定
            datePicker.minuteInterval = 15
        
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}
