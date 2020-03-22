//
//  Reservation01ViewController.swift
//  MagotakuApp
//
//  Created by 宮本一成 on 2020/03/06.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FSCalendar

class Reservation01ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UINavigationControllerDelegate {
    
    
    //カレンダー定義
    fileprivate weak var calendar: FSCalendar!
    var titleLabel = UILabel()
    @IBOutlet weak var nextBtn: UIButton!
    
    var selectedDate: [Int]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //NavigationBarのタイトル設定
        self.title = "訪問希望日をタップしてください"
        

        
        //カレンダーの設定について
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        //カレンダーの表記を日本語化
        calendar.appearance.headerDateFormat = "YYYY年MM月"
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
        
        //今日が既に選択された状態になっているのを解除して、違う色をつけたい
        
        
        //次へボタンの設定
        nextBtn.layer.cornerRadius = 24
        nextBtn.backgroundColor = UIColor.gray
        nextBtn.isEnabled = false
    }
    
    
    override func viewDidLayoutSubviews() {
        let safeAreaTopHeight = self.view.safeAreaInsets.top
        let safeAreaBottomHeight = self.view.safeAreaInsets.bottom
//        let tabbarHeight = self.tabBarController?.tabBar.frame.height
        print(safeAreaBottomHeight)
        
//        titleLabel.frame = CGRect(x: 8, y: safeAreaHeight + 16, width: UIScreen.main.bounds.width - 64, height: 22)
        calendar.frame = CGRect(x: 0, y: safeAreaTopHeight , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - safeAreaTopHeight - safeAreaBottomHeight - 160)
//        calendar.frame = CGRect(x: 0, y: safeAreaTopHeight + 24 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
//        nextBtn.frame = CGRect(x: 32, y: UIScreen.main.bounds.height - safeAreaBottomHeight - 60, width: UIScreen.main.bounds.width - 64, height: 48)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //ボタンを使用可能にして、色を変える
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = UIColor(red: 124/255, green: 143/255, blue: 230/255, alpha: 1)
        //選択した日付を変数に代入する
        selectedDate = getDay(date)
        if selectedDate != nil{
            print(selectedDate!)
        }else{
            showErrorAlert(text: "日付が選択されてないよ！")
        }
    }
    
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> [Int]{
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        let date: [Int] = [year, month, day]
        return date
    }

    @IBAction func tapToNext(_ sender: Any) {
//        let vc = Reservation02ViewController()
//        vc.selectedDate = selectedDate
//        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backButtonItem
//        navigationController?.pushViewController(vc, animated: true)
        let preNC = self.navigationController!
        let preVC = preNC.viewControllers[preNC.viewControllers.count - 2] as! Reservation00ViewController
        preVC.calendarDate = "\(self.selectedDate[0])年\(self.selectedDate[1])月\(self.selectedDate[2])日"
        
        
        //選択画面に戻る
//        let preNV = self.presentingViewController as! UINavigationController
        navigationController?.popViewController(animated: true)
    }
}
