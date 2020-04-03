//
//  HomeViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/29.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var reservationBtn: UIButton!
    @IBOutlet weak var viewForBtn: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        titleView.image = UIImage(systemName: "paperclip.circle.fill")
//        self.navigationItem.titleView = titleView
        self.title = "ホーム"
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]

     
        
//        reservationBtn.backgroundColor = UIColor(red: 244/255, green: 176/255, blue: 131/255, alpha: 1)
        
        // ログインユーザーのプロフィール取得
        
        //navigationBarにグラデーションカラーセット
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //tabbarの高さをsafeareaの高さを含めて取得する
        var tabbarHeight = tabBarController?.tabBar.bounds.size.height
        tabbarHeight! += additionalSafeAreaInsets.bottom
        
        //承認用のviewとbtnのframeをここで確定
        viewForBtn.frame = CGRect(x: 0, y: self.view.bounds.height - tabbarHeight! - 72, width: UIScreen.main.bounds.width, height: 72)
        viewForBtn.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        reservationBtn.frame = CGRect(x: 32, y: 12, width: UIScreen.main.bounds.width - 64, height: 48)
        reservationBtn.layer.cornerRadius = 24
    }

    
    //新規予約1に飛ばす
    @IBAction func takeReserve(_ sender: Any) {
        let vc = Reservation00ViewController()
        //戻るボタンの設定
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    

    
    
    

}
