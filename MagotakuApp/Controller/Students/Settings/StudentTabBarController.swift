







import UIKit

class StudentTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景色
        tabBar.barTintColor = UIColor.white
        // アイテムの色
        tabBar.tintColor = UIColor.black
        
        let firstVC = MainNavigationController(rootViewController: SearchViewController())
        firstVC.tabBarItem = UITabBarItem(title: "探す", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let secondVC = MainNavigationController(rootViewController: StudentReservationViewController())
        secondVC.tabBarItem = UITabBarItem(title: "予約一覧", image: UIImage(systemName: "tray.fill"), tag: 1)
        
        let thirdVC = MainNavigationController(rootViewController: StudentProfileViewController())
        thirdVC.tabBarItem = UITabBarItem(title: "マイページ", image: UIImage(systemName: "person.fill"), tag: 2)
        
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        
        
    }
    

  

}
