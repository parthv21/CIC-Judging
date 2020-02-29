//
//  Alerts.swift
//  CIC Judging
//
//  Created by Parth Tamane on 28/02/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

/**
 Function to generate an alert informing user of error.
 - Parameters:
 - title: The title of the alert controller
 - message: The error message to be shown
 - Returns: An UIAlertController with passed title and message
 */

func makeAlert(title: String, message: String) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
        alertController.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(dismissAction)
    return alertController
}
