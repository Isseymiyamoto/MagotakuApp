//
//  SearchViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase

//var studentProfile: StudentUser!
var studentProfile: StudentUser = StudentUser()

class SearchViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "探す"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        //学生情報をfetchして表示する
        
        
        if studentProfile.uid != ""{
            print("studentProfile.uid:\(studentProfile.uid)")
            testLabel.text = studentProfile.uid
        }else{
            testLabel.text = "いやえぐいて"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += self.additionalSafeAreaInsets.top
            gradient.frame = bounds
            gradient.colors = [UIColor(red: 41/255, green: 162/255, blue: 226/255, alpha: 1).cgColor, UIColor(red: 65/255, green: 132/255, blue: 190/255, alpha: 1).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)

            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }


    

}
