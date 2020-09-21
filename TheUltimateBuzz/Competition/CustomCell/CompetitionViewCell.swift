//
//  CompetitionViewCell.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 09/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class CompetitionViewCell: UITableViewCell {

    @IBOutlet var cellbackgroundView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var titleImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func manageCompetitionCell(titleArray: NSArray, indexpath : IndexPath){
        titleLbl.text = titleArray[indexpath.row] as? String
        titleImg.image = UIImage(named: titleArray[indexpath.row] as! String)
    }
}
