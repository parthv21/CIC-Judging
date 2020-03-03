//
//  KeyMaker.swift
//  CIC Judging
//
//  Created by Parth Tamane on 03/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import Firebase

func getUserPhoneNumber() -> String {
    let user = Auth.auth().currentUser
    return String((String(user?.phoneNumber ?? "").removingPercentEncoding ?? "").suffix(10))
}
