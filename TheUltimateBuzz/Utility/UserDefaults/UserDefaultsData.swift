//
//  UserDefaultsData.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 07/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class UserDefaultsData: NSObject {
    
    static let shared = UserDefaultsData()
    
    private override init (){
    }

    func saveIntoDefault(key: String, value: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getFromDefaults(key: String) -> String{
        guard let value = UserDefaults.standard.string(forKey: key) else { return "No Record Found"}
        return value
    }
    
    func isUserPinned() -> Bool
    {
        guard let result = UserDefaults.standard.string(forKey: "email") else { return false}
        return result.isEmpty ? false : true
    }
    
    func isUserEntered() -> Bool
    {
        guard let result = UserDefaults.standard.string(forKey: "isEnteredCompetition") else { return false}
        return result.isEmpty ? false : true
    }
    
    func removeUser(){
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
    func removeUserFromCompetition(){
        UserDefaults.standard.removeObject(forKey: "isEnteredCompetition")
    }
}
