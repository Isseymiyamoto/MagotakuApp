//
//  CustomTextFiled.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    //paddingの設定
    var padding = CGPoint(x: 20.0, y: 0.0)
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
    }
      
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
    }
      
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
    }
}
