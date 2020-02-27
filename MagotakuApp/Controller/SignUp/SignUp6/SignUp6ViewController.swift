//
//  SignUp6ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class SignUp6ViewController: UIViewController {
    
    @IBOutlet weak var photoLabel: UILabel!
    //プロフィール写真が入るImageView
//    let profileImage: UIImageView! = UIImageView()
    @IBOutlet weak var profileImage: UIImageView!
    
    //ImageViewの上に載せるタップジェスチャーレコグナイザー
//    let tapRec: UITapGestureRecognizer! = UITapGestureRecognizer(target: self, action: #selector(open))
    //次へボタン
    @IBOutlet weak var nextBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBarのタイトル
        self.title = "サービス利用者情報"
        
        //ImageViewについて位置以外の設定
        profileImage.backgroundColor = UIColor(red: 99/255, green: 101/255, blue: 105/255, alpha: 1)
        self.view.addSubview(profileImage)
        
        //タップイベントがブロックされないようにする
        profileImage.isUserInteractionEnabled = true
         
    }
    
    override func viewDidLayoutSubviews() {
        let photoLoc:CGFloat? = photoLabel.frame.origin.y
        let screenWidth = UIScreen.main.bounds.size.width
        //プロファイルイメージ用のUIImageViewを用意
        profileImage.frame = CGRect(x: screenWidth / 6, y: photoLoc! + 38, width: screenWidth * 2 / 3, height: screenWidth * 2 / 3)
        //タップゲスチャーの配置
//        profileImage.addGestureRecognizer(tapRec)
        
        //次へボタンの配置
        nextBtn.frame = CGRect(x: 32, y: screenWidth * 2 / 3  + photoLoc! + 54, width: screenWidth - 64, height: 48)
        nextBtn.layer.cornerRadius = 6.0
    }
    
    @IBAction func tapToNext(_ sender: Any) {
        let vc = SignUp7ViewController()
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func open(_ sender: Any) {
        let alert = UIAlertController(title: "写真", message: "サービス利用者のお顔がわかる写真をアップロードしてください", preferredStyle: .actionSheet)
        //ボタン1
        alert.addAction(UIAlertAction(title: "カメラで撮影", style: .default, handler: nil))
        //ボタン２
        alert.addAction(UIAlertAction(title: "アルバムから選択", style: .default, handler: nil))
        //ボタン３
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        //アクションシートを表示する
        self.present(alert, animated: true, completion: nil)
        
        print("タップジェスチャーが押されT年")
    }
    
//    @objc func open(){
//        //アクションシートを作る
//        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .actionSheet)
//        //ボタン1
//        alert.addAction(UIAlertAction(title: "カメラで撮影", style: .default, handler: nil))
//        //ボタン２
//        alert.addAction(UIAlertAction(title: "アルバムから選択", style: .default, handler: nil))
//        //ボタン３
//        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction) in
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        //アクションシートを表示する
//        self.present(alert, animated: true, completion: nil)
//
//        print("タップジェスチャーが押されT年")
//    }
    
    
    

   
   
}
