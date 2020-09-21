//
//  LoginViewModel.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 30/07/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class LoginViewModel: UIView {

    func savedLogedInUser(email: String){
        print(email)
        UserDefaultsData.shared.saveIntoDefault(key: "email", value: email)
    }
}
