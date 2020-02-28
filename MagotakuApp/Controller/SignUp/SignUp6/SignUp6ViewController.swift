//
//  SignUp6ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/02/27.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Photos

class SignUp6ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoLabel: UILabel!
    //プロフィール写真が入るImageView
    @IBOutlet weak var profileImage: UIImageView!
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
        
        
        //photoライブラリの使用許可
        PHPhotoLibrary.requestAuthorization{(status) in
            switch(status){
            case .authorized:
                print("許可されています")
            case .denied:
                print("拒否されました")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("制限されています")
            }
        }
         
    }
    
    override func viewDidLayoutSubviews() {
        let photoLoc:CGFloat? = photoLabel.frame.origin.y
        let screenWidth = UIScreen.main.bounds.size.width
        //プロファイルイメージ用のUIImageViewを用意
        profileImage.frame = CGRect(x: screenWidth / 6, y: photoLoc! + 38, width: screenWidth * 2 / 3, height: screenWidth * 2 / 3)
        
        //次へボタンの配置
        nextBtn.frame = CGRect(x: 32, y: screenWidth * 2 / 3  + photoLoc! + 54, width: screenWidth - 64, height: 48)
        nextBtn.layer.cornerRadius = 6.0
    }
    
    @IBAction func tapToNext(_ sender: Any) {
        if profileImage.image != nil{
            let vc = SignUp7ViewController()
            let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButtonItem
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    @IBAction func open(_ sender: Any) {
        let alert = UIAlertController(title: "写真", message: "サービス利用者のお顔がわかる写真をアップロードしてください", preferredStyle: .actionSheet)
        //ボタン1
        alert.addAction(UIAlertAction(title: "カメラで撮影", style: .default, handler: { (action) in
            self.openCaemra()
        }))
        //ボタン２
        alert.addAction(UIAlertAction(title: "アルバムから選択", style: .default, handler: {(action) in
            self.openAlbum()
        }))
        //ボタン３
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        //アクションシートを表示する
        self.present(alert, animated: true, completion: nil)
    }
   
    
    //カメラを使用するためのメソッド
    func openCaemra(){
        let sourceType = UIImagePickerController.SourceType.camera
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //変数化
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
        }else{
            print("エラー")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //アルバムを使用するためのメソッド
    func openAlbum(){
        let sourceType = UIImagePickerController.SourceType.photoLibrary
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //変数化
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
        }else{
            print("エラー")
            
        }
    }
    
    //撮影が完了した時に呼ばれる(アルバムから写真が選択された時に呼ばれる場所)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage{
            profileImage.image = pickedImage

            let lastVC = SignUp8ViewController()
            lastVC.getImage = pickedImage
            
            //写真の保存
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            picker.dismiss(animated: true, completion: nil)
        }
    }
   
    
}
