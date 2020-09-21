//
//  VotingListCell.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 09/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class VotingListCell: UITableViewCell {

    var isChecked = false
    @IBOutlet var numberLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var voteLbl: UILabel!
    @IBOutlet var voteBtnObj: UIButton!
    var intVal : Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func manageVotingListCell(numberArray: NSArray, nameArray: NSArray, voteArray: NSArray, indexpath: IndexPath){
        numberLbl.text = numberArray[indexpath.row-1] as? String
        nameLbl.text = nameArray[indexpath.row-1] as? String
        intVal = Int((voteArray[indexpath.row-1] as? String)!)
        voteLbl.text = String(intVal)
    }
    
    @IBAction func voteBtnClicked(_ sender: Any) {
        isChecked = !isChecked
        if isChecked {
            voteBtnObj.setImage(UIImage(named: "Voting_selected"), for: .normal)
            intVal = intVal + 1
            voteLbl.text = String(intVal)
        } else {
            voteBtnObj.setImage(UIImage(named: "Voting"), for: .normal)
            intVal = intVal - 1
            voteLbl.text = String(intVal)
        }
    }
}
