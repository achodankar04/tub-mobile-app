//
//  RulesVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 09/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class RulesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func closeBtnClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
