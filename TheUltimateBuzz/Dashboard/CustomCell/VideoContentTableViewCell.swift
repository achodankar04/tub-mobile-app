//
//  VideoContentTableViewCell.swift
//  CDHApplication
//
//  Created by Sagar C on 15/07/20.
//  Copyright © 2020 BNT SOFT. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import WebKit

class VideoContentTableViewCell: UITableViewCell {
    
    @IBOutlet var likeBtnObj: UIButton!
    @IBOutlet var videoTitleLbl: UILabel!
    @IBOutlet var previewImgView: UIImageView!
    
    var isChecked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeBtnClicked(_ sender: Any) {
        isChecked = !isChecked
        if isChecked {
            likeBtnObj.setImage(UIImage(named: "Voting_selected"), for: .normal)
        } else {
            likeBtnObj.setImage(UIImage(named: "Voting"), for: .normal)
        }
    }
    func manageVideoCell(){}
}

