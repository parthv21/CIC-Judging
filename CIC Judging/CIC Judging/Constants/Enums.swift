//
//  Enums.swift
//  CIC Judging
//
//  Created by Parth Tamane on 03/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation

enum FilterVCType: String {
    case JudgedTeams = "Judged Teams"
    case AllTeams = "All Teams"
}

enum VCType {
    case LoginVC
    case TeamListVC
    case FilterAllTeamsVC
    case FilterJudgedTeamsVC
    case None
}

enum ScoringCriterion: String {
    case Usability = "usability"
    case Innovation = "innovation"
    case Viability = "viability"
    case Presentation = "presentation"
    case Notes = "notes"
}

