//
//  AlertControllerUtility.swift
//  CDHApplication
//
//  Created by Sagar C on 18/06/20.
//  Copyright © 2020 BNT SOFT. All rights reserved.
//

import Foundation
import UIKit

struct AlertTitle{
    static let Error = "Error"
    static let AreYouSure = "Are you sure?"
}

struct AlertMessages{
    static let ResetUser = "Logging in to another account will reset your biometric login."
    static let CommonErrorMessage = "Sorry something went wrong, please try again"
    static let SetupInPhoneSettings = "You need to set-up %@ to use this feature."
    static let NoInternetConnection = "No internet connection"
}

struct AlertButtonTitle{
    static let OK = "OK"
    static let Cancel = "CANCEL"
    static let Confirm = "CONFIRM"
    static let Reset = "RESET"
    static let PhoneSettings = "Phone settings"
}


class AlertControllerUtility {

    static let shared = AlertControllerUtility()

    private init (){}

    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = [], cancelButtonTitle: String, cancelButtonAction: UIAlertAction? = nil )
    {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           for action in actions {
               alertController.addAction(action)
           }
           if cancelButtonAction != nil {
               alertController.addAction(cancelButtonAction!)
           } else {
               alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (action) in
                   DispatchQueue.main.async {
                       alertController.dismiss(animated: true, completion: nil)
                   }
               }))
           }
           DispatchQueue.main.async {
            if var topController = UIApplication.shared.keyWindow?.rootViewController  {
                  while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                       }
            topController.present(alertController, animated: true, completion: nil)
           }
       }
    }
    
    func showAlertSingleButton(title: String, message: String, actions: [UIAlertAction] = [])
    {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           for action in actions {
               alertController.addAction(action)
           }
           
           DispatchQueue.main.async {
            if var topController = UIApplication.shared.keyWindow?.rootViewController  {
                  while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                       }
            topController.present(alertController, animated: true, completion: nil)
           }
       }
    }


}
