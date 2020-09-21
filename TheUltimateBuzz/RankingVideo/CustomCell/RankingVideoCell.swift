//
//  RankingVideoCell.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 10/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class RankingVideoCell: UITableViewCell {

    @IBOutlet var vieoTitleLbl: UILabel!
    @IBOutlet var likeBtnObj: UIButton!
    var isChecked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func manageRankingCell(nameArray: NSArray, indexpath: IndexPath){
        vieoTitleLbl.text = nameArray[indexpath.row] as? String
    }
    
    @IBAction func likeBtnClicked(_ sender: Any) {
        isChecked = !isChecked
        if isChecked {
            likeBtnObj.setImage(UIImage(named: "Voting_selected"), for: .normal)
        } else {
            likeBtnObj.setImage(UIImage(named: "Voting"), for: .normal)
        }
    }
    
}
