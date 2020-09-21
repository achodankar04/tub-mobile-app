//
//  LiveVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 02/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class LiveVC: UIViewController {

    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
    }


    // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
        topNavigationBar.titleLable.text = "Live"
        topNavigationBar.leftImgView.isHidden = true
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }

}
