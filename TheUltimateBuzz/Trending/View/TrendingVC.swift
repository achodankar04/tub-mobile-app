//
//  TrendingVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 02/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class TrendingVC: UIViewController {

    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
    }

    // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
        topNavigationBar.titleLable.text = "Trending"
        topNavigationBar.leftImgView.isHidden = true
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }

}
