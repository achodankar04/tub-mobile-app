
//
//  UserProfileVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 07/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet var userTableView: UITableView!
    var userProfileArray = ["About Us", "Support", "Endocing", "Contact Us", "Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerUserTableViews()
    }
    
    fileprivate func registerUserTableViews(){
        userTableView.tableFooterView = UIView()
        let userCell = UINib(nibName: "UserProfileCell", bundle: nil)
        userTableView.register(userCell, forCellReuseIdentifier: "UserProfileCell")
        
        let userInfoCell = UINib(nibName: "UserInfoCell", bundle: nil)
        userTableView.register(userInfoCell, forCellReuseIdentifier: "UserInfoCell")
    }
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func logOutUser(){
        UserDefaultsData.shared.removeUser()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        appDelegate().setApplicationRootViewToTabbarController()
        
    }
    
}

extension UserProfileVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell") as! UserInfoCell
            cell.manageInfoCell()
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.contentView.layer.masksToBounds  = true
            cell.layer.cornerRadius = 5
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell") as! UserProfileCell
            cell.manageUserCell(userArray: userProfileArray as NSArray, indexpath: indexPath)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.contentView.layer.masksToBounds  = true
            cell.layer.cornerRadius = 5
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 100
        }else{
            return 65
        }        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 5:
            self.logOutUser()
        default:
            break
        }
    }
}
