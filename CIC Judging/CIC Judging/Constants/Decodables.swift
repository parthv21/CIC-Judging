//
//  Decodables.swift
//  CIC Judging
//
//  Created by Parth Tamane on 01/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation

struct TeamData: Codable {
    let affinityGroup: String
    let descp: String
    let logoUrl: String
    let posterUrl: String
    let projectUrl: String
    let resumeUrl: String
    let team: [String]
    let teamId: Int
    let teamName: String
    let timestamp: String
    let videoUrl: String
}

struct ScoresData: Codable {
    let innovation: Int
    let presentation: Int
    let usability: Int
    let viability: Int
    let notes: String
}

struct MessageData: Codable {
    let timestamp: String
    let message: String
    let priority: String
}

struct ConfigurationData: Codable {
    let allowEdits: Int
    let allowSubmissions: Int
}
