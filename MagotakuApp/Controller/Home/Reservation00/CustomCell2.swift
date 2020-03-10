//
//  CustomCell2.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/10.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomCell2: UITableViewCell {
    
    // ピッカー設定
    var datePicker2 = UIDatePicker()
    
    @IBOutlet weak var customTF2: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        datePicker2.timeZone = NSTimeZone.local
        datePicker2.locale = Locale(identifier: "ja") //日本語に変更
        datePicker2.datePickerMode = UIDatePicker.Mode.time//形式を指定
        datePicker2.minuteInterval = 15
    }
    
}
