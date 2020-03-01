//
//  Decodables.swift
//  CIC Judging
//
//  Created by Parth Tamane on 01/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation

struct TeamMember: Codable {
    var name: String
    var resume: String
}

struct TeamData: Codable {
    var affinityGroup: String
    var descp: String
    var team: [TeamMember]
    var teamId: Int
    var teamName: String
    var timestamp: String
}

