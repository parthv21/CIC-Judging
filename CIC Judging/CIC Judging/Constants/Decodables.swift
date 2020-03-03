//
//  Decodables.swift
//  CIC Judging
//
//  Created by Parth Tamane on 01/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation

struct TeamData: Codable {
    var affinityGroup: String
    var descp: String
    var logoUrl: String
    var posterUrl: String
    var projectUrl: String
    var resumeUrl: String
    var team: [String]
    var teamId: Int
    var teamName: String
    var timestamp: String
    var videoUrl: String
}

