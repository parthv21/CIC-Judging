//
//  Validators.swift
//  CIC Judging
//
//  Created by Parth Tamane on 28/02/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation

/**
 Validate a phone number provided as input.
 - Parameters:
    - phoneNumber: The phonenumber provided by user
 - Returns: True if valid phone number else false
 */
func validatePhoneNumber(_ phoneNumber: String) -> Bool {
    let regexString = "^(\\+\\d{1,2}[\\s]?)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$"
    do {
        let regex = try NSRegularExpression(pattern: regexString, options: .caseInsensitive)
        return regex.firstMatch(in: phoneNumber, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, phoneNumber.count)) != nil
    } catch {
        return false
    }
}


