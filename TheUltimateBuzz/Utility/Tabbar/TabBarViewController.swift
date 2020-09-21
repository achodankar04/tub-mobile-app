
import UIKit

class TabBarViewController: UITabBarController {
        
    //let tabBarVM = TabbarViewModel()
    let dashboardViewObj = DashboardVC()
    let searchObj = SearchVC()
    let competitionObj = CompetitionVC()
    let trendingObj = TrendingVC()
    let liveObj = LiveVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dashboardViewObj.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        dashboardViewObj.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 20)
        dashboardViewObj.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15.0)
        let navigationHome = UINavigationController(rootViewController: dashboardViewObj)
        navigationHome.navigationBar.isTranslucent = false
        navigationHome.navigationBar.isHidden = true;

        searchObj.tabBarItem = UITabBarItem(title: "Serach", image: UIImage(named: "search"), tag: 1)
        searchObj.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 20)
        searchObj.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15.0)
        let navigationSearch = UINavigationController(rootViewController: searchObj)
        navigationSearch.navigationBar.isTranslucent = false
        navigationSearch.navigationBar.isHidden = true;
        
        competitionObj.tabBarItem = UITabBarItem(title: "Competition", image: UIImage(named: "medal"), tag: 1)
        competitionObj.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 20)
        competitionObj.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15.0)
        let navigationCompetition = UINavigationController(rootViewController: competitionObj)
        navigationCompetition.navigationBar.isTranslucent = false
        navigationCompetition.navigationBar.isHidden = true;
        
        trendingObj.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(named: "trending"), tag: 2)
        trendingObj.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 20)
        trendingObj.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15.0)
        let navigationTrending = UINavigationController(rootViewController: trendingObj)
        navigationTrending.navigationBar.isTranslucent = false
        navigationTrending.navigationBar.isHidden = true;
        
        liveObj.tabBarItem = UITabBarItem(title: "Subscription", image: UIImage(named: "live"), tag: 3)
        liveObj.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 20)
        liveObj.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15.0)
        let navigationLive = UINavigationController(rootViewController: liveObj)
        navigationLive.navigationBar.isTranslucent = false
        navigationLive.navigationBar.isHidden = true;
                
        self.viewControllers = [navigationHome,navigationSearch,navigationCompetition,navigationTrending,navigationLive]
        self.selectedIndex = 0
        tabBar.tintColor = UIColor(red: 246.0/255.0, green: 178.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor.gray
        tabBar.barTintColor = UIColor.white
    }
}
