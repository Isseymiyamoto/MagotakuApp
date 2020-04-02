//
//  EditProfileViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Photos

class EditProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let titleLabels:[String] = ["あなたの名前", "あなたの年齢", "あなたの性別", "あなたの在籍校", "あなたの電話番号", "あなたの趣味", "あなたの関心ある区域"]
    let imageLists:[String] = ["person.fill", "calendar.circle.fill", "person.crop.rectangle.fill", "house.fill", "phone.fill", "bookmark", "square.grid.2x2.fill"]
    let profileInfo: [String] = [studentProfile.name, studentProfile.age, studentProfile.sex, studentProfile.school, studentProfile.phoneNum, studentProfile.hobby, studentProfile.address]
    
    var imageView = UIImageView()
    var studentImage: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "基本情報"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        let saveButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveProfile))
        navigationItem.rightBarButtonItem = saveButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //photoライブラリの使用許可
               PHPhotoLibrary.requestAuthorization{(status) in
                   switch status {
                   case .authorized:
                       print("許可されています")
                   case .denied:
                       print("拒否されました")
                   case .notDetermined:
                       print("notDetermined")
                   case .restricted:
                       print("制限されています")
                   @unknown default:
                       print(Error.self)
                   }
               }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tableView再描画
        tableView.reloadData()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleLabels.count
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = titleLabels[indexPath.section]
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            cell.imageView?.image = UIImage(systemName: imageLists[indexPath.section])
            //セル選択時にハイライトさせない
            cell.selectionStyle = .none
            return cell
        default:
            let cell1 = UITableViewCell(style: .value1, reuseIdentifier: "cell1")
            cell1.textLabel?.text = profileInfo[indexPath.section]
            //セルの右端にタッチ利用可能の補助イメージ
            let touchImage = UIImageView()
            touchImage.image = UIImage(systemName: "chevron.right")
            touchImage.frame = CGRect(x: UIScreen.main.bounds.width - 32, y: (cell1.bounds.height / 5) * 2 , width: 8, height: cell1.bounds.height / 5)
            cell1.contentView.addSubview(touchImage)
            
            return cell1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    //headerViewを設置
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView()
            view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
            //もし学生側に情報としてimageNameが入っていたらそれを取得して表示させる
            if let imageName: String? = studentProfile.imageName,
                let ref = StudentUserCollection.shared.getImageRef(imageName: imageName!){
                imageView.sd_setImage(with: ref)
            }else{
                imageView = UIImageView(image: UIImage(systemName: "person.fill"))
            }
            
            imageView.backgroundColor = UIColor(red: 99/255, green: 101/255, blue: 105/255, alpha: 1)
            imageView.frame = CGRect(x: (UIScreen.main.bounds.width / 8) * 3, y: (240 - UIScreen.main.bounds.width / 4) / 2, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
            imageView.layer.cornerRadius = UIScreen.main.bounds.width / 8
            //タップイベントがブロックされないようにする
            imageView.isUserInteractionEnabled = true
            view.addSubview(imageView)
            let button = UIButton(type: .system)
            button.frame = CGRect(x: UIScreen.main.bounds.width / 4, y:  (UIScreen.main.bounds.width / 4) + (248 - UIScreen.main.bounds.width / 4) / 2, width: UIScreen.main.bounds.width / 2, height: 12)
            button.setTitle("プロフィール写真を登録・変更", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
            view.addSubview(button)
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 240
        default:
            return 0
        }
    }
    
    
    @objc func tapBtn(sender: UIButton){
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
                imageView.image = pickedImage
                studentImage = pickedImage
                
                //写真の保存
                UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
                picker.dismiss(animated: true, completion: nil)
            }
        }
       
    @objc func saveProfile(){
        print("saveProfileが押されたよ")
        //写真が挿入されている場合
        if studentImage != nil{
            StudentUserCollection.shared.saveImage(image: studentImage) { (imageName) in
                guard let imageName = imageName else{
                    return
                }
                studentProfile.imageName = imageName
                StudentUserCollection.shared.editProfile(studentProfile)
            }
            navigationController?.popViewController(animated: true)
        }else{
            print("変更内容はありません")
        }
    }


}
