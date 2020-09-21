//
//  RegexValidator.swift
//  CDHApplication
//
//  Created by Rahul Varma on 30/05/20.
//  Copyright © 2020 BNT SOFT. All rights reserved.
//

import Foundation

final class RegexValidator {
    static let sharedInstance = RegexValidator()
    private init() { }

    func validateWithRegex(regex : String, for value : String) -> Bool
    {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: value) ? true : false
    }
    
    func validatePassword(password : String, with length : Int) -> Bool
    {
        if password.count >= length &&
            password.rangeOfCharacter(from: .decimalDigits) != nil &&
            password.rangeOfCharacter(from: .uppercaseLetters) != nil &&
            password.rangeOfCharacter(from: .lowercaseLetters) != nil
        {
            print("Valid Password Format")
            return true
        }
        else
        {
            print("Password Format is Invalid")
            return false
        }
    }
}
