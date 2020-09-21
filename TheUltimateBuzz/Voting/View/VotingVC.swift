//
//  VotingVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 09/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class VotingVC: UIViewController {

    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var topNavigationView: BuzzNavigationBar!
    @IBOutlet var emailTxtFieldObj: UITextField!
    @IBOutlet var infoLbl: UILabel!
    @IBOutlet var codeTxtFieldObj: UITextField!
    @IBOutlet var submitBtnObj: UIButton!
    @IBOutlet var codeBottomLine: UILabel!
    @IBOutlet var verifyBtnObj: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
        initialiseView()
    }


   // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
       topNavigationView.titleLable.text = "Voting"
       topNavigationView.leftImgView.isHidden = true
        if self.topNavigationView.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }
    
    fileprivate func initialiseView(){
        infoLbl.isHidden = true
        codeTxtFieldObj.isHidden = true
        submitBtnObj.isHidden = true
        codeBottomLine.isHidden = true
    }
    
    @IBAction func verifyBtnClicked(_ sender: Any) {
        if emailTxtFieldObj.text == ""{
            
        }else{
            infoLbl.isHidden = false
            codeTxtFieldObj.isHidden = false
            submitBtnObj.isHidden = false
            codeBottomLine.isHidden = false
        }
        
    }
    @IBAction func submitBtnClicked(_ sender: Any) {
        let rankingVC = RankingVideoVC(nibName: "RankingVideoVC", bundle: nil)
        self.navigationController?.pushViewController(rankingVC, animated: true)
    }
}

