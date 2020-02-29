//
//  RefCheckers.swift
//  CIC Judging
//
//  Created by Parth Tamane on 29/02/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import Firebase

/**
 Function to check if user has registered or not
 - Parameters:
    - phoneNumber: The phone number of the user trying to login
 - Returns: true if the user has registered else false
 */
func checkIfUserRegistred(phoneNumber: String, completion: @escaping (Bool) -> ()) {
    checkIfChildExists(parentPath: "judges", childKey: phoneNumber) {keyExists in
        completion(keyExists)
    }
}

/**
 Function to check if a parent has a child key
 - Parameters:
    - parentPath: Path to the root of parent
    - childKey: The child key to be checked
 - Returns: true if the parent path has the child key else false
 */
func checkIfChildExists(parentPath: String, childKey: String, completion: @escaping (Bool) -> ()) {
    let ref = Database.database().reference()
    ref.child(parentPath).observeSingleEvent(of: .value, with: { (snapshot) in
        completion(snapshot.hasChild(childKey))
    })
}
