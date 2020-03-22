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
    
    
    
    //collectonView
    @IBOutlet weak var collectionView: UICollectionView!
    //カレンダー定義
    fileprivate weak var calendar: FSCalendar!
    
    //スクロールビュー
    @IBOutlet weak var scrollView: UIScrollView!
    //スクロールビューに載せるUIView
    var view1 = UIView()
    
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
        view.addSubview(calendar)
        self.calendar = calendar
        
        //カレンダーの表記を日本語化
        self.calendar = calendar
//        calendar.appearance.headerDateFormat = "YYYY年MM月"
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

        horizontalScroll()
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

    //スクロールビューに対するメソッド
    func horizontalScroll(){
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        //view1のframe
        view1.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width * 2, height: scrollView.frame.size.height)
        view1.backgroundColor = .systemRed
        //タブ的なボタン設置
        for i in 0...6{
            let button = UIButton()
            button.frame = CGRect(x: (i*100), y: 10, width: 80, height: 55)
            button.tag = i
            setTitleForButton(tag: button.tag, button: button)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.layer.borderWidth = 1
            view1.addSubview(button)
        }
        scrollView.addSubview(view1)
        scrollView.contentSize = view1.bounds.size
    }

    //スクロールビューのボタンに文字を挿入
    func setTitleForButton(tag: Int, button:UIButton){
        switch tag {
        case 0:
            button.setTitle("おしゃべり", for: .normal)
        case 1:
            button.setTitle("イヤイヤ", for: .normal)
        case 2:
            button.setTitle("テクノロジー", for: .normal)
        case 3:
            button.setTitle("おしゃべり", for: .normal)
        case 4:
            button.setTitle("おしゃべり", for: .normal)
        case 5:
            button.setTitle("おしゃべり", for: .normal)
        default:
            button.setTitle("おしゃべり", for: .normal)
        }
    }
        
    
    
    // collectionViewについての実装
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReservationCollection.shared.reservationCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        return cell
    }

}

