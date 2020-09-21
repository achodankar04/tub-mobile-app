//
//  ArchiveVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 10/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class ArchiveVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    @IBOutlet var archiveTableView: UITableView!
    
    let tableViewData = [
        ["Cooking Audition","Crafting Audition","Dance Audition","Music Audition"],
        ["5 min craft","Best Non-veg Recipie", "Best Hip-Hop","Drum sticks magic"],
        ["America's got Tilent","Talk with Nature","How to cook lobster","Dance moves"],
    ]
    let sectionTitle = ["Audition", "Week1", "Week2"]
    var hiddenSections = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initiailTopView()
        archiveTableView.tableFooterView = UIView()
    }
    
    //MARK: - user defined methods
    fileprivate func initiailTopView(){
       topNavigationBar.titleLable.text = "Archives"
       topNavigationBar.leftImgView.isHidden = true
        if self.topNavigationBar.hasTopNotch {
                   self.navigationBarHeight.constant = 120
               }
               else {
                   self.navigationBarHeight.constant = 90
               }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
               return 0
           }
        return self.tableViewData[section].count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell()
           cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
           
           return cell
       }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        sectionButton.setTitle(sectionTitle[section], for: .normal)
        sectionButton.setTitleColor(UIColor.black, for: .normal)
        sectionButton.contentHorizontalAlignment = .left
        sectionButton.setImage(UIImage(named: "down-arrow"), for: .normal)
        sectionButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 350, bottom: 10, right: 20)
        sectionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 20)
        sectionButton.backgroundColor = .white
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)),for: .touchUpInside)
        return sectionButton
    }
    
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.archiveTableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.archiveTableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
