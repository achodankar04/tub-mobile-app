//
//  AppDelegate.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 29/07/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit
func appDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //setApplicationRootView()
        setApplicationRootViewToTabbarController()
        removeUserFromCompetition()
        return true
    }
    
    func setApplicationRootView(){
        if UserDefaultsData.shared.isUserPinned(){
            setApplicationRootViewToTabbarController()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            setApplicationRootView(rootVC: rootVc)
        }
    }
    
    //This function is temp to remove the saved user for competition
    func removeUserFromCompetition(){
        UserDefaultsData.shared.removeUserFromCompetition()
    }
    func setApplicationRootViewToTabbarController()
    {
        DispatchQueue.main.async {
            let tabbarObj = TabBarViewController()
            self.setApplicationRootView(rootVC: tabbarObj)
        }
    }
    
    func setApplicationRootView(rootVC : UIViewController)
    {
        DispatchQueue.main.async {
            let navigationController = UINavigationController(rootViewController: rootVC)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.isHidden = true;
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
    }
}

