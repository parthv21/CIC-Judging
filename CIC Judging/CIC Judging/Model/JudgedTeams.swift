//
//  ScoredTeams.swift
//  CIC Judging
//
//  Created by Parth Tamane on 12/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import Firebase

class JudgedTeams {
    
    static let shared = JudgedTeams()
    var judgedTeamIds = [Int]()
    
    private init() {
        let ref = Database.database().reference()
        ref.child(judgedTeamsKey).child(getUserPhoneNumber()).observe(.value) { (snapshot) in
            if let teamIds = snapshot.value as? [String: Int] {
                self.judgedTeamIds = teamIds.map{ $0.1 }
            }
        }
    }
}

