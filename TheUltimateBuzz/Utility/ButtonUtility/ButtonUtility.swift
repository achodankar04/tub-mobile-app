//
//  ButtonUtility.swift
//  CDHApplication
//
//  Created by BNT ADMIN on 26/05/20.
//  Copyright © 2020 BNT SOFT. All rights reserved.
//

import Foundation
import UIKit

class ButtonUtility {
    static let shared = ButtonUtility()
    
    private init (){
    }
    
    func setButtonEnable(button : UIButton){
        button.backgroundColor = UIColor(red: 223.0/255.0, green: 47.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        button.titleLabel?.textColor = UIColor.white
        button.isUserInteractionEnabled = true
    }
    
    func setButtonDisable(button : UIButton){
        button.backgroundColor = UIColor(red: 238.0/255.0, green: 166.0/255.0, blue: 37.0/255.0, alpha: 0.5)
        button.titleLabel?.textColor = UIColor(red: 243.0/255.0, green: 195.0/255.0, blue: 128.0/255.0, alpha: 0.5)
        button.isUserInteractionEnabled = false
    }
    
    func leftButtonClickAction() {
        print("left button clicked")
    }
    
    func RightButtonClickAction() {
        print("right button clicked")
        if UserDefaultsData.shared.isUserPinned(){
            let userProfileView = UserProfileVC(nibName: "UserProfileVC", bundle: nil)
            userProfileView.modalPresentationStyle = .fullScreen
            let currentController = self.getCurrentViewController()
            currentController?.present(userProfileView, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            rootVc.modalPresentationStyle = .fullScreen
            let currentController = self.getCurrentViewController()
            currentController?.present(rootVc, animated: true, completion: nil)
        }
        

    }
    
    func getCurrentViewController() -> UIViewController? {

        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil

    }
}

