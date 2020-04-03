//
//  DetailSearchViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import PKHUD


class DetailSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
//    let test = UILabel()
    //承認用のviewとbtn
    @IBOutlet weak var viewForBtn: UIView!
    @IBOutlet weak var requestBtn: UIButton!
    
    
    //前のVCから値わたしされるようの変数
    var detailNum:Int!
    var seniorImage: UIImage!
    
    @IBOutlet weak var tableView: UITableView!
    
    var reservationInfo: Reservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "リクエスト詳細"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let detailNum = detailNum{
            print(detailNum)
            reservationInfo = StudentReservationCollection.shared.getReservation(at: detailNum)
        }
        
        
        //使用するcustomCellの設定
        let nib = UINib(nibName: "DetailReservationCell", bundle: nil)
        tableView.register( nib, forCellReuseIdentifier: "DetailReservationCell")
        
        
        //承認用btnを載せるview
        viewForBtn.layer.shadowOffset = CGSize.zero
        viewForBtn.layer.shadowColor = UIColor.black.cgColor
        viewForBtn.layer.shadowOpacity = 0.6
        viewForBtn.layer.shadowRadius = 4
        
        
        
//        test.frame = CGRect(x: 0, y: self.view.bounds.height - tabbarHeight! - 22, width: 100, height: 22)
//        test.backgroundColor = UIColor.black
//        view.addSubview(test)
//        view.bringSubviewToFront(test)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //tabbarの高さをsafeareaの高さを含めて取得する
        var tabbarHeight = tabBarController?.tabBar.bounds.size.height
        tabbarHeight! += additionalSafeAreaInsets.bottom
//        tableViewのframe設定
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.bounds.height - tabbarHeight! - 72)

        //承認用のviewとbtnのframeをここで確定
        viewForBtn.frame = CGRect(x: 0, y: self.view.bounds.height - tabbarHeight! - 72, width: UIScreen.main.bounds.width, height: 72)
        requestBtn.frame = CGRect(x: 32, y: 12, width: UIScreen.main.bounds.width - 64, height: 48)
        requestBtn.layer.cornerRadius = 24
        
//        test.frame = CGRect(x: 0, y: self.view.bounds.height - tabbarHeight! - 22, width: 100, height: 22)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 192
        case 1:
            return 240
        default:
            return 360
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailReservationCell") as! DetailReservationCell
                        
            //タイトルに関する設定
            cell.titleLabel.frame = CGRect(x: 16, y: 32, width: UIScreen.main.bounds.width - 32, height: 22)
            
            //日程部分のアイコン設定
            let dateIcon = UIImageView(image: UIImage(systemName: "calendar.circle"))
            dateIcon.frame = CGRect(x: 16, y: 86, width: 22, height: 22)
            cell.addSubview(dateIcon)
            //日程部分に関する設定
            cell.dateLabel.text = "2020年4月22日(火)"
            cell.dateLabel.frame = CGRect(x: 60, y: 86, width: UIScreen.main.bounds.width - 40, height: 22)
            
            //時間部分のアイコン設定
            let timeIcon = UIImageView(image: UIImage(systemName: "timer"))
//            timeIcon.frame = CGRect(x: 16, y: 140, width: 22, height: 22)
            timeIcon.frame = CGRect(x: 16, y: 112, width: 22, height: 22)
            cell.addSubview(timeIcon)
            
            //時間部分に関する設定
            cell.timeLabel.text = "14:00 - 18:00"
            cell.timeLabel.frame = CGRect(x: 60, y: 112, width: UIScreen.main.bounds.width - 40, height: 22)
            
            //位置のアイコン設定
            let locationIcon = UIImageView(image: UIImage(systemName: "location"))
//            locationIcon.frame = CGRect(x: 16, y: 194, width: 22, height: 22)
            locationIcon.frame = CGRect(x: 16, y: 138, width: 22, height: 22)
            cell.addSubview(locationIcon)
            
            //位置部分に関する設定
            cell.locationLabel.text = "都営地下鉄銀座線 表参道駅 徒歩12分"
            cell.locationLabel.frame = CGRect(x: 60, y: 138, width: UIScreen.main.bounds.width - 40, height: 22)
            
            return cell
            
        case 1:
            
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
                        
            //titleLabelの設定
            let titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.text = "お手伝い内容について"
            titleLabel.frame = CGRect(x: 16, y: 32, width: UIScreen.main.bounds.width - 32, height: 22)
            cell.addSubview(titleLabel)
            
            //お手伝い内容についてを複数作成していく
            let helpContents = ["傾聴", "ITレッスン", "家事", "散歩", "おしゃべり", "その他"]
            let helpIcons = ["pencil", "pencil.circle", "pencil", "pencil.circle", "pencil", "pencil.circle"]
            let background: [UIColor] = [.red, .blue, .brown, .systemPink, .cyan, .darkGray]
            
            for i in 0..<(reservationInfo?.helpContents!.count)!{
                //iconとlabelを配置するためのviewを生成する
                let view1 = UIView()
                view1.frame = CGRect(x: (16 + ((UIScreen.main.bounds.width - 32) / 3) * CGFloat(i)), y: 86, width: (UIScreen.main.bounds.width - 32) / 3, height: (UIScreen.main.bounds.width - 32) / 3)
                cell.addSubview(view1)
                
                //viewに載せるiconについて
                let iconView = UIView()
//                iconView.backgroundColor = background[(reservationInfo?.helpContents![i])!]
                iconView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
                iconView.frame = CGRect(x: view1.bounds.width / 6, y: 0, width: (view1.bounds.width / 3)*2, height: (view1.bounds.width / 3)*2)
//                iconView.layer.cornerRadius = iconView.bounds.width / 2
                iconView.layer.cornerRadius = 6.0
                view1.addSubview(iconView)
                
                let iconImageView = UIImageView(image: UIImage(systemName: "\(helpIcons[(reservationInfo?.helpContents![i])!])"))
                iconImageView.frame = CGRect(x: iconView.bounds.width / 4, y: iconView.bounds.height / 4, width: iconView.bounds.width / 2, height: iconView.bounds.width / 2)
                iconView.addSubview(iconImageView)
                
                //viewに載せるlabel
                let contentLabel = UILabel()
                contentLabel.text = helpContents[(reservationInfo?.helpContents![i])!]
                contentLabel.font = UIFont.boldSystemFont(ofSize: 12)
                contentLabel.textAlignment = .center
                contentLabel.adjustsFontSizeToFitWidth = true
                contentLabel.frame = CGRect(x: 0, y: (view1.bounds.width / 3) * 2 + 4, width: view1.bounds.width, height: 22)
                view1.addSubview(contentLabel)
            }
            
            
            return cell
                        
        case 2:
            
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            //titleLabelの設定
            let titleLabel = UILabel()
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.text = "注意事項について"
            titleLabel.frame = CGRect(x: 16, y: 32, width: UIScreen.main.bounds.width - 32, height: 22)
            cell.addSubview(titleLabel)
            
            //背景がgrayのViewを用意してその上に記載する
            let view = UIView()
            view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            view.frame = CGRect(x: 16, y: 86, width: UIScreen.main.bounds.width - 32, height: 160)
            cell.addSubview(view)
            
            //viewに載せるtextViewを生成する
            let textView = UITextView()
            textView.frame = CGRect(x: 4, y: 2, width: view.bounds.size.width - 8, height: 156)
            textView.text = "特筆事項なし"
            textView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            textView.isEditable = false
            view.addSubview(textView)
            
            return cell
            
        default:
            
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = "テストタイトル"
            return cell
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
//            return 160
            return  (UIScreen.main.bounds.width / 3) * 2
        default:
            return 0
        }
    }

//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 64
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //プロフィール写真用のUIImageView
        let profileImage = UIImageView()
//        profileImage.frame = CGRect(x: (UIScreen.main.bounds.width - 72) / 2, y: 32, width: 72, height: 72)
//        profileImage.layer.cornerRadius = 30.0
        //test的に
//        profileImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160)
        profileImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 3) * 2)
        profileImage.contentMode = .scaleToFill
        //imageの挿入
        profileImage.image = seniorImage
        

        //サービス利用者詳細情報に飛ばすbtn設置
        let detailBtn = UIButton(type: .system)
        detailBtn.frame = CGRect(x: UIScreen.main.bounds.width - 248, y: ((UIScreen.main.bounds.width / 3) * 2) - 40, width: 240, height: 32)
        detailBtn.backgroundColor = .white
        detailBtn.layer.cornerRadius = 4.0
        detailBtn.titleLabel?.textAlignment = .center
        detailBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        detailBtn.setTitle("詳細プロフィールを閲覧する", for: .normal)
        detailBtn.addTarget(self, action: #selector(tapDetailProfile), for: .touchUpInside)

        //各パーツを載せるためのUIView
        let view = UIView()
        view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.addSubview(profileImage)
        view.addSubview(detailBtn)
        
        
        return view
    }
    
    //detailBtn用のメソッド
    @objc func tapDetailProfile(){
        let vc = PartSeniorProfileViewController()
        vc.imageView.image = seniorImage
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
        
    //セルタップ時にハイライトしないようにする
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    //訪問を希望するボタンを押した際の挙動を設定
    @IBAction func tapRequestBtn(_ sender: Any) {
        // 1. 学生側にprofileImageがない場合
        // rofileImageを登録するように促す
        if studentProfile.imageName == nil{
            showErrorAlert2(title: "プロフィール未完成" ,text: "ご自身の顔写真が未登録です。訪問のリクエストには、ご自身の顔写真登録は必須となります。マイアカウントのプロフィールから登録できます。")
            
        }else{
            // 2. profileImageがある場合
            // reservationに、stUidを追加
            reservationInfo?.stUid = Auth.auth().currentUser!.uid
            // reservationの、reservationNumを1に変更する
            reservationInfo?.reservationNum = 1
            //actionsheetにて最終確認
            finalVertification(reservation: reservationInfo!)
            //reservationが格納されている配列からそデータを取り除く
            
            //searchViewControllerに戻る
            
        }
        
        
        
        
    }
    
    
    func finalVertification(reservation: Reservation){
        let alert = UIAlertController(title: "確認", message: "訪問を希望でお間違い無いですか？", preferredStyle: .actionSheet)
        //ボタン1
        alert.addAction(UIAlertAction(title: "はい", style: .default, handler: { (action) in
            //予約をupdateする
            StudentReservationCollection.shared.finishReservation(reservation, deleteNum: self.detailNum)
        }))
        //ボタン2
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        //アクションシートを表示する
        self.present(alert, animated: true, completion: nil)
    }
    
   

}
