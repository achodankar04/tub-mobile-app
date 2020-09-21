//
//  UserInfoCell.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 07/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet var userProfilePic: UIImageView!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userEmailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func manageInfoCell(){
        let userEmail = UserDefaultsData.shared.getFromDefaults(key: "email")
        userEmailLbl.text = userEmail
        let index2 = userEmail.range(of: "@", options: .backwards)?.lowerBound
        let substring3 = index2.map(userEmail.substring(to:))
        userNameLbl.text = substring3
        
    }
}
