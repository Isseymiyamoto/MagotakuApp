//
//  TextView.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/03.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

//後で消す。いらないやつ。

import Foundation
import UIKit

class TextView: UIView {
    
    let mainLabel: UILabel
    
    init(frame: CGRect, text: String) {
        
        self.mainLabel = UILabel()
        self.mainLabel.text = text
        // 表示テキストのセンタリング
        self.mainLabel.textAlignment = .center
        // 親クラスを初期化
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(mainLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let labelSize = self.mainLabel.sizeThatFits(self.bounds.size)
        
        let x = (self.bounds.width - labelSize.width) / 2
        let y = (self.bounds.height - labelSize.height) / 2
        let labelOrigin = CGPoint(x: x, y: y)
        
        self.mainLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
        
    }
    
}
