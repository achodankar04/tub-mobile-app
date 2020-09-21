//
//  CompetitionVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 05/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class CompetitionVC: UIViewController {
    
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var competitionTbleView: UITableView!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    var competitioArray = ["Enter Competition","Ranking","Voting","Archives", "Rules"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
        registerTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        competitionTbleView.reloadData()
    }

  // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
        topNavigationBar.titleLable.text = "Competition"
        topNavigationBar.leftImgView.isHidden = true
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }

    fileprivate func registerTableView(){
        let competitionCell = UINib(nibName: "CompetitionViewCell", bundle: nil)
        competitionTbleView.register(competitionCell, forCellReuseIdentifier: "CompetitionViewCell")
        competitionTbleView.showsVerticalScrollIndicator = false
        competitionTbleView.tableFooterView = UIView()
        competitionTbleView.bounces = false
    }
    
    func enterCompetition(){
        let competitionView = EnterCompetitionVC(nibName: "EnterCompetitionVC", bundle: nil)
        self.navigationController?.pushViewController(competitionView, animated: true)
    }
    
    func enterRanking(){
        let votingView = VotingListVC(nibName: "VotingListVC", bundle: nil)
        self.navigationController?.pushViewController(votingView, animated: true)
    }
    
    func enterVoting(){
        let votingView = VotingVC(nibName: "VotingVC", bundle: nil)
        self.navigationController?.pushViewController(votingView, animated: true)
    }
    
    func showRules(){
        let rulesView = RulesVC(nibName: "RulesVC", bundle: nil)
        rulesView.modalPresentationStyle = .fullScreen
        self.navigationController?.present(rulesView, animated: true, completion: nil)
    }
    func showArchives(){
        let archiveView = ArchiveVC(nibName: "ArchiveVC", bundle: nil)
        self.navigationController?.pushViewController(archiveView, animated: true)
    }
}

extension CompetitionVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionViewCell") as! CompetitionViewCell
        cell.manageCompetitionCell(titleArray: competitioArray as NSArray, indexpath: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.contentView.layer.masksToBounds  = true
        cell.layer.cornerRadius = 5
        if indexPath.row == 0{
            if UserDefaultsData.shared.isUserEntered(){
                cell.isUserInteractionEnabled = false
                cell.backgroundColor = UIColor(red: 245.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1.0)
                cell.cellbackgroundView.backgroundColor = UIColor(red: 245.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.enterCompetition()
        case 1:
            self.enterRanking()
        case 2:
            self.enterVoting()
        case 3:
            self.showArchives()
        case 4:
            self.showRules()
        default:
            break
        }
    }
}
