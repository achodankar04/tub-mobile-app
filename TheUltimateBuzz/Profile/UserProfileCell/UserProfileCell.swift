//
//  UserProfileCell.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 07/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet var userImg: UIImageView!
    @IBOutlet var userTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func manageUserCell(userArray: NSArray, indexpath: IndexPath){
        userImg.image = UIImage(named: userArray[indexpath.row-1] as! String)
        userTitleLbl.text = (userArray[indexpath.row-1] as! String)
    }
}
