//
//  SearchViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FSCalendar

//学生側プロフィールの初期化
var studentProfile: StudentUser = StudentUser()

class SearchViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //calendar用のView
    @IBOutlet weak var calendarView: UIView!
    
    //scrollViewに設置されているButtonについて、どれが選択されているかtag番号で識別
    var tagNumber = 1
    
    //選択している日付を反映する為のUILabel
    @IBOutlet weak var dateLabel: UILabel!

    //テスト的に前予約をfetchできているか確認する
    var reservationCount = StudentReservationCollection.shared.allReservationCount()
    
    //collectonView
    @IBOutlet weak var collectionView: UICollectionView!
    //カレンダー定義
    fileprivate weak var calendar: FSCalendar!
    
    //スクロールビュー
    @IBOutlet weak var scrollView: UIScrollView!
    //スクロールビューに載せるUIView
    var view1 = UIView()
    
    //スクリーンサイズ取得用
    let x = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "探す"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.white
        ]
        
       
        
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        calendarView.addSubview(calendar)
        self.calendar = calendar
        
        //カレンダーの表記を日本語化
        self.calendar = calendar
        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        self.calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        self.calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        self.calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        self.calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        self.calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        self.calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        //曜日毎にテキストカラーを変更
        self.calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        self.calendar.calendarWeekdayView.weekdayLabels[1].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[2].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[3].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[4].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[5].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue
        
        self.calendar.calendarHeaderView.isHidden = true
        self.calendar.headerHeight = 12.0
        self.calendar.setScope(.week, animated: false)
        self.calendar.pagingEnabled = true

        
        //collectionViewの設定
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "CustomReservationCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomReservationCell")
        
        //レイアウト設定
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: (x.width / 5) * 2, height: x.width / 2)
//        layout.minimumLineSpacing = x.width / 10
//        layout.sectionInset = UIEdgeInsets(top: 16, left: x.width / 15, bottom: 16, right: x.width / 15)
        
        layout.itemSize = CGSize(width: (x.width - 48) / 2, height: (x.width / 2) + 32)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.collectionViewLayout = layout
        
        print("reservationCountを出力しますよ")
        print(reservationCount)
        print("reservationCountを出力しますよ")
        
        
        //dateLabelには今日の日付を入れておく
        dateLabel.text = "\(toStringWithCurrentLocale(date: Date()))"
        
        
        //ボタンを生成するfunction
        horizontalScroll()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
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
            gradient.endPoint = CGPoint(x: 1, y: 0)

            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
            
            //calendarViewのheightを設定する
            calendarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 88)
            //scrollViewのframe決定
            scrollView.frame = CGRect(x: 0, y: 92, width: UIScreen.main.bounds.width, height: 40)
            dateLabel.frame = CGRect(x: 16, y: 148, width: UIScreen.main.bounds.width - 32, height: 12)
            collectionView.frame = CGRect(x: 0, y: 164, width: UIScreen.main.bounds.width, height: 600)
            
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

    //スクロールビューに対するメソッド
    func horizontalScroll(){
        print("horizontalScrollが呼ばれました")
        
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        //view1のframe
        view1.frame = CGRect(x: 16, y: 0, width: scrollView.frame.size.width * 2, height: scrollView.frame.size.height)
        //タブ的なボタン設置
        for i in 0...6{
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.frame = CGRect(x: (i*80), y: 4, width: 64, height: 32)
            button.tag = i + 1
            setTitleForButton(tag: button.tag, button: button)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 12
            button.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.layer.borderWidth = 1
            button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            if button.tag == 1{
                button.backgroundColor = UIColor(red: 124/255, green: 143/255, blue: 230/255, alpha: 1)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
                print(button.frame)
            }
            
            view1.addSubview(button)
        }
        scrollView.addSubview(view1)
        scrollView.contentSize = view1.bounds.size
    }
    
    //cellを選択した際の挙動
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailSearchViewController()
        vc.detailNum = indexPath.row
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //上部scrollViewに配置したUIButtonに対してタップ時の挙動を追加
    @objc func tapButton(sender: UIButton!){
        print(sender.tag)
        print(tagNumber)
        
        if sender.tag != tagNumber{
            // 1.tagNumber目のUIButtonのbackgroundとfontを元に戻す
            let button = self.view1.viewWithTag(tagNumber) as? UIButton
            print(type(of: button))
            print(button as Any)
            button?.backgroundColor = UIColor.white
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            // 2.タップされたsenderのbackgroundとfontを変更する
            let button1 = self.view1.viewWithTag(sender.tag) as? UIButton
            button1!.backgroundColor = UIColor(red: 124/255, green: 143/255, blue: 230/255, alpha: 1)
            button1!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            // 3.tagNumberを選ばれたsender.tag番目に変更する
            tagNumber = sender.tag
        }else{
            return
        }
    }
    
    

    //スクロールビューのボタンに文字を挿入
    func setTitleForButton(tag: Int, button:UIButton){
        switch tag {
        case 1:
            button.setTitle("全て", for: .normal)
        case 2:
            button.setTitle("傾聴", for: .normal)
        case 3:
            button.setTitle("ITレッスン", for: .normal)
        case 4:
            button.setTitle("家事", for: .normal)
        case 5:
            button.setTitle("散歩", for: .normal)
        case 6:
            button.setTitle("おしゃべり", for: .normal)
        default:
            button.setTitle("その他", for: .normal)
        }
    }

    
    // collectionViewについての実装
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StudentReservationCollection.shared.allReservationCount()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomReservationCell", for: indexPath) as! CustomReservationCell
        
        
        cell.seniorImage.frame = CGRect(x: 0, y: 0, width: cell.bounds.size.width , height: cell.bounds.size.width)
        cell.seniorImage.layer.cornerRadius = 6
        //test的にseniorImageのframeをtwitter風に変えてみる
//        cell.seniorImage.frame = CGRect(x: 0, y: 0, width: cell.bounds.size.width / 3, height: cell.bounds.size.width / 3)
//        cell.seniorImage.layer.cornerRadius = cell.bounds.size.width / 6
        
        //日付用の位置設定、文字フォント設定
        cell.dateLabel.frame = CGRect(x: 0, y: cell.bounds.size.width + 8, width: cell.bounds.size.width / 2, height: 16)
        cell.dateLabel.textAlignment = .left
        cell.dateLabel.text = "\(StudentReservationCollection.shared.getReservation(at: indexPath.row).visitDate)"
        cell.dateLabel.font = .systemFont(ofSize: 12)
        cell.dateLabel.textColor = .darkGray
        
        //時間用の位置設定、文字フォント設定
        cell.timeLabel.frame = CGRect(x: 0, y: cell.bounds.size.width + 24, width: cell.bounds.size.width / 2, height: 16)
        cell.timeLabel.textAlignment = .left
        cell.timeLabel.text = "14:00 - 18:00"
        cell.timeLabel.font = .systemFont(ofSize: 12)
        cell.timeLabel.textColor = .darkGray
        
        //予想請求金額についての位置設定、文字フォント設定
        cell.expectedPrice.frame = CGRect(x: cell.bounds.size.width / 2, y: cell.bounds.size.width + 16, width: cell.bounds.size.width / 2, height: 24)
        cell.expectedPrice.textAlignment = .right
        cell.expectedPrice.text = "¥\(StudentReservationCollection.shared.getReservation(at: indexPath.row).ExpectedPrice)"
        cell.expectedPrice.font = .boldSystemFont(ofSize: 16)
        
        //cellのUIImageViewに対して、seniorImageを配置する
        if let imageName: String = StudentReservationCollection.shared.getReservation(at: indexPath.row).seniorImage, let ref = StudentReservationCollection.shared.getImageRef(uid: StudentReservationCollection.shared.getReservation(at: indexPath.row).seUid, imageName: imageName){
            cell.seniorImage.sd_setImage(with: ref)
        }else{
           cell.seniorImage.image = UIImage(systemName: "pencil.circle")
        }
        
        
        return cell
    }
    
    
    //選択された日付を取得
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        dateLabel.text = "\(year)年\(month)月\(day)日"
    }
    
    //selectedDateに反映する為のformatter
    func toStringWithCurrentLocale(date: Date) -> String {

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

}


