//
//  AppConfigurations.swift
//  CIC Judging
//
//  Created by Parth Tamane on 12/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import Firebase

class AppConfigurations {
    
    static let shared = AppConfigurations()
    var appConfigurations = ConfigurationData(allowEdits: 1, allowSubmissions: 1)

    private init() {
        let ref = Database.database().reference()
        ref.child(configurationKey).observe(.value) { (snapshot) in
            do {
                let value = snapshot.value
                let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                print(value)
                let decodedConfigurations =  try JSONDecoder().decode(ConfigurationData.self, from: data)
                self.appConfigurations = decodedConfigurations
            } catch {
                print(error)
            }
        }
    }
}




