//
//  VotingListVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 09/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class VotingListVC: UIViewController {
    @IBOutlet var votingListTableViewObj: UITableView!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    var btnTitleStr : String!
    
    let nameArray = ["Tom", "Jerry", "Matthews", "Budiman", "Andrews", "Habby", "Jessica", "Stefan", "Klaus", "Jack"]
    let numberArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let votesArray = ["5465", "5222", "4800", "4350", "4200", "4000","3985","3900","3880","3850"]
    let categoryArray = ["All","Acting","Comedy","Dance","Magic","Music","Sport","Cooking","Crafting"]
    
    
    var actingCategory = ["Acting", "Acting"]
    var danceCategory = ["Dance", "Dance"]
    var musicCategory = ["Music","Music","Music"]
    var sportsCategory = ["Sport","Sport","Sport"]
    
    var actingCatNumber = ["1","2"]
    var danceCatNumber = ["1","2"]
    var musicCatNumber = ["1","2","3"]
    var sportCatNumber = ["1","2","3"]
    
    var actingCatName = ["Tom","Jerry"]
    var danceCatName = ["Matthews","Budiman"]
    var musicCatName = ["Andrews","Habby","Jessica"]
    var sportCatName = ["Stefan","Klaus","Jack"]
    
    var actingVotes = ["5465","5222"]
    var danceVote = ["4800","4350"]
    var musicVote = ["4200","4000","3985"]
    var sportVote = ["3900","3880","3850"]
    
    
    
    @IBOutlet var chooseCategoryBtn: UIButton!
    @IBOutlet var pickerViewBackground: UIView!
    @IBOutlet var categoryPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
        initialiseTable()
        
        chooseCategoryBtn.setTitle("Choose Category :- All", for: .normal)
        btnTitleStr = chooseCategoryBtn.titleLabel?.text
    }


     // MARK: - User Defined methods
       
       fileprivate func initialiseTopBar(){
        topNavigationBar.titleLable.text = "Ranking"
        topNavigationBar.leftImgView.isHidden = true
        pickerViewBackground.isHidden = true
        categoryPicker.isHidden = true
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
       }
    
    func initialiseTable(){
        votingListTableViewObj.tableFooterView = UIView()
        let userCell = UINib(nibName: "VotingListCell", bundle: nil)
        votingListTableViewObj.register(userCell, forCellReuseIdentifier: "VotingListCell")
        
        let votingTitleCell = UINib(nibName: "VotingListTitleCell", bundle: nil)
        votingListTableViewObj.register(votingTitleCell, forCellReuseIdentifier: "VotingListTitleCell")
        
        votingListTableViewObj.showsVerticalScrollIndicator = false
        votingListTableViewObj.tableFooterView = UIView()
        votingListTableViewObj.bounces = true
    }

    @IBAction func categoryBtnClicked(_ sender: Any) {
        pickerViewBackground.isHidden = false
        categoryPicker.isHidden = false
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        pickerViewBackground.isHidden = true
        categoryPicker.isHidden = true
        
    }
}

extension VotingListVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
        chooseCategoryBtn.setTitle("Choose Category :- \(itemselected)", for: .normal)
        btnTitleStr = "Choose Category :- \(itemselected)"
        votingListTableViewObj.reloadData()
    }
}

extension VotingListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTitleStr == "Choose Category :- All"{
            return nameArray.count+1
        }else if btnTitleStr == "Choose Category :- Acting"{
            return actingCategory.count+1
        }else if btnTitleStr == "Choose Category :- Dance"{
            return danceCategory.count+1
        }else if btnTitleStr == "Choose Category :- Music"{
            return musicCategory.count+1
        }else if btnTitleStr == "Choose Category :- Sport"{
            return sportCatName.count+1
        }else {
            return nameArray.count+1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "VotingListTitleCell") as! VotingListTitleCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.contentView.layer.masksToBounds  = true
            cell.layer.cornerRadius = 5
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VotingListCell") as! VotingListCell
            //cell.manageVotingListCell(numberArray: numberArray as NSArray, nameArray: nameArray as NSArray, voteArray: votesArray as NSArray, indexpath: indexPath)
            
            if btnTitleStr == "Choose Category :- All"{
                cell.manageVotingListCell(numberArray: numberArray as NSArray, nameArray: nameArray as NSArray, voteArray: votesArray as NSArray, indexpath: indexPath)
            }else if btnTitleStr == "Choose Category :- Acting"{
                cell.manageVotingListCell(numberArray: actingCatNumber as NSArray, nameArray: actingCatName as NSArray, voteArray: actingVotes as NSArray, indexpath: indexPath)
            }else if btnTitleStr == "Choose Category :- Dance"{
                cell.manageVotingListCell(numberArray: danceCatNumber as NSArray, nameArray: danceCatName as NSArray, voteArray: danceVote as NSArray, indexpath: indexPath)
            }else if btnTitleStr == "Choose Category :- Music"{
                cell.manageVotingListCell(numberArray: musicCatNumber as NSArray, nameArray: musicCatName as NSArray, voteArray: musicVote as NSArray, indexpath: indexPath)
            }else if btnTitleStr == "Choose Category :- Sport"{
                cell.manageVotingListCell(numberArray: sportCatNumber as NSArray, nameArray: sportCatName as NSArray, voteArray: sportVote as NSArray, indexpath: indexPath)
            }else {
                cell.manageVotingListCell(numberArray: numberArray as NSArray, nameArray: nameArray as NSArray, voteArray: votesArray as NSArray, indexpath: indexPath)
            }
            
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.contentView.layer.masksToBounds  = true
            cell.layer.cornerRadius = 5
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
