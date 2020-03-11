//
//  DateParser.swift
//  CIC Judging
//
//  Created by Parth Tamane on 10/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation

func parseISODateString(isoDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return dateFormatter.date(from: isoDate) ?? Date(timeIntervalSince1970: 0)
}

func timestampToString(isoDate: String) -> String {
    let date = parseISODateString(isoDate: isoDate)
    let dateReformatter = DateFormatter()
    dateReformatter.dateFormat = "MM-dd-yy, HH:mm"
    return dateReformatter.string(from: date)
}
