//
//  FontMaker.swift
//  CIC Judging
//
//  Created by Parth Tamane on 05/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

func getBoldFont(text: String) -> NSAttributedString {
    return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: contentFontBold ?? UIFont.boldSystemFont(ofSize: 15)])
}

func getRegularFont(text: String) -> NSAttributedString {
    return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: contentFontRegular ?? UIFont.systemFont(ofSize: 15)])
}
