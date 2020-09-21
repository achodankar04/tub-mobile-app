//
//  DashboardVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 31/07/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import WebKit
import MBProgressHUD

class DashboardVC: UIViewController,BuzzNavigationBarDelegate {
    
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    @IBOutlet var contentTableViewObj: UITableView!
    @IBOutlet var categoryBtnObj: UIButton!
    @IBOutlet var pickerViewBackgroubd: UIView!
    var dashboardVM = DashboardViewModel()
    var hud : MBProgressHUD?
    var categoryArray = ["All", "Acting","Comedy","Dance","Magic","Music","Sport","Cooking","Crafting"]
    
    var actingCategory = ["Acting", "Acting"]
    var danceCategory = ["Dance", "Dance"]
    var musicCategory = ["Music","Music","Music"]
    var sportsCategory = ["Sport","Sport","Sport"]
    var btnTitleStr : String!
        
    var videoArray = [String]()
    var nameArray = [String]()
    var imageArray = [String]()
    
    var delegate : DashboardProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialiseTopBar()
        registerTableViews()
        callAPI()
    }

    // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
        topNavigationBar.titleLable.isHidden = true
        topNavigationBar.buzzNavigationDelegate = self
        pickerViewBackgroubd.isHidden = true
        categoryPickerView.isHidden = true
        categoryBtnObj.setTitle("Choose Category :- All", for: .normal)
        btnTitleStr = categoryBtnObj.titleLabel?.text
    }
    
    fileprivate func registerTableViews(){
        let accountsCell = UINib(nibName: "VideoContentTableViewCell", bundle: nil)
        contentTableViewObj.register(accountsCell, forCellReuseIdentifier: "VideoContentCell")
        contentTableViewObj.showsVerticalScrollIndicator = false
    
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }
 
    @IBAction func categoryButtonClicked(_ sender: Any) {
      pickerViewBackgroubd.isHidden = false
      categoryPickerView.isHidden = false
    }
    @IBAction func doneBtnClicked(_ sender: Any) {
        pickerViewBackgroubd.isHidden = true
        categoryPickerView.isHidden = true
    }
    
    func callAPI(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.label.text = "Loading"
        dashboardVM.callAPI()
        dashboardVM.delegate = self
    }
}
extension DashboardVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        if btnTitleStr == "Choose Category :- All"{
            return videoArray.count
        }else if btnTitleStr == "Choose Category :- Acting"{
            return actingCategory.count
        }else if btnTitleStr == "Choose Category :- Dance"{
            return danceCategory.count
        }else if btnTitleStr == "Choose Category :- Music"{
            return musicCategory.count
        }else if btnTitleStr == "Choose Category :- Sport"{
            return sportsCategory.count
        }else {
            return videoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoContentCell") as! VideoContentTableViewCell
        cell.manageVideoCell()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentView.layer.masksToBounds  = true
        cell.layer.cornerRadius = 5
        if(indexPath.row == 0)
        {
            cell.likeBtnObj.isHidden = false
        }else if(indexPath.row == 1)
        {
            cell.likeBtnObj.isHidden = false
        }else if(indexPath.row == 2)
        {
            cell.likeBtnObj.isHidden = false
        }else{
            cell.likeBtnObj.isHidden = true
        }
        let url = URL(string: imageArray[indexPath.row])!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            cell.previewImgView.image = UIImage(data: imageData)
        }
        cell.videoTitleLbl.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoURL = NSURL(string: videoArray[indexPath.row])
        let playerviewcontroller = AVPlayerViewController()
        var playerview = AVPlayer()
        playerview = AVPlayer(url: videoURL! as URL)
        playerviewcontroller.player = playerview
        self.present(playerviewcontroller, animated: true){
            playerviewcontroller.player?.play()
        }
    }
}

extension DashboardVC : UIPickerViewDataSource, UIPickerViewDelegate{
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
        categoryBtnObj.setTitle("Choose Category :- \(itemselected)", for: .normal)
        btnTitleStr = "Choose Category :- \(itemselected)"
        contentTableViewObj.reloadData()
    }
}

extension DashboardVC : VideoResponseDelegate{
    func passVideoResponse(videoDict: Dictionary<String, Any>) {
        let videoURL = videoDict["VideoUrl"] as? Dictionary<String,Any>
        imageArray.append((videoDict["Thumbnail"] as? String)!)
        let mp4 = videoURL?["mp4_Low"] as? Dictionary<String,Any>
        let mp3 = videoURL?["mp3"] as? Dictionary<String,Any>
        videoArray.append((mp4?["url"] as? String ?? mp3?["url"] as? String ?? videoDict["videoLink"] as? String)!)
        nameArray.append(videoDict["title"] as Any as! String)
        contentTableViewObj.reloadData()
        hud?.hide(animated: true)
    }
}
