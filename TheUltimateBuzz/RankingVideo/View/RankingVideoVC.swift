//
//  RankingVideoVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 10/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class RankingVideoVC: UIViewController {

    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var categoryPickerBackground: UIView!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var doneBtnObj: UIButton!
    @IBOutlet var voteVideoTblViewObj: UITableView!
    @IBOutlet var categoryBtn: UIButton!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    
    var categoryArray = ["All", "Acting","Comedy","Dance","Magic","Music","Sport","Cooking","Crafting"]
    var videoDetailArray = ["Acting", "Dance","Music","Sport", "Acting","Dance","Music","Sport","Music","Sport"]
    var actingCategory = ["Acting", "Acting"]
    var danceCategory = ["Dance", "Dance"]
    var musicCategory = ["Music","Music","Music"]
    var sportsCategory = ["Sport","Sport","Sport"]
    var btnTitleStr : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
        registerTableView()
    }


    // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
       topNavigationBar.titleLable.text = "Voting"
       topNavigationBar.leftImgView.isHidden = true
        
       categoryPickerBackground.isHidden = true
       categoryPickerView.isHidden = true
       categoryBtn.setTitle("Choose Category :- All", for: .normal)
       btnTitleStr = categoryBtn.titleLabel?.text
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }
    
    fileprivate func registerTableView(){
        let rankingCell = UINib(nibName: "RankingVideoCell", bundle: nil)
        voteVideoTblViewObj.register(rankingCell, forCellReuseIdentifier: "RankingVideoCell")
        voteVideoTblViewObj.showsVerticalScrollIndicator = false
        voteVideoTblViewObj.tableFooterView = UIView()
        voteVideoTblViewObj.bounces = false
    }
    
    @IBAction func categoryBtnClicked(_ sender: Any) {
        categoryPickerBackground.isHidden = false
        categoryPickerView.isHidden = false
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        categoryPickerBackground.isHidden = true
        categoryPickerView.isHidden = true
    }
    
}

extension RankingVideoVC : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemselected = categoryArray[row]
        categoryBtn.setTitle("Choose Category :- \(itemselected)", for: .normal)
        btnTitleStr = "Choose Category :- \(itemselected)"
        voteVideoTblViewObj.reloadData()
    }
}

extension RankingVideoVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTitleStr == "Choose Category :- All"{
            return videoDetailArray.count
        }else if btnTitleStr == "Choose Category :- Acting"{
            return actingCategory.count
        }else if btnTitleStr == "Choose Category :- Dance"{
            return danceCategory.count
        }else if btnTitleStr == "Choose Category :- Music"{
            return musicCategory.count
        }else if btnTitleStr == "Choose Category :- Sport"{
            return sportsCategory.count
        }else {
            return videoDetailArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingVideoCell") as! RankingVideoCell
        //
        
        if btnTitleStr == "Choose Category :- All"{
            cell.manageRankingCell(nameArray: videoDetailArray as NSArray, indexpath: indexPath)
        }else if btnTitleStr == "Choose Category :- Acting"{
            cell.manageRankingCell(nameArray: actingCategory as NSArray, indexpath: indexPath)
        }else if btnTitleStr == "Choose Category :- Dance"{
            cell.manageRankingCell(nameArray: danceCategory as NSArray, indexpath: indexPath)
        }else if btnTitleStr == "Choose Category :- Music"{
            cell.manageRankingCell(nameArray: musicCategory as NSArray, indexpath: indexPath)
        }else if btnTitleStr == "Choose Category :- Sport"{
            cell.manageRankingCell(nameArray: sportsCategory as NSArray, indexpath: indexPath)
        }else {
            cell.manageRankingCell(nameArray: videoDetailArray as NSArray, indexpath: indexPath)
        }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentView.layer.masksToBounds  = true
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
