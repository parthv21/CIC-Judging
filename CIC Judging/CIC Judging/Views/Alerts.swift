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

//func makeAlert(title: String, message: String) -> UIAlertController {
//    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    let dismissAction = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
//        alertController.dismiss(animated: true, completion: nil)
//    }
//    alertController.addAction(dismissAction)
//    return alertController
//}

/**
Function to generate an alert informing user of error and allowing a callback for dismiss.
- Parameters:
- title: The title of the alert controller
- callback: The function executed when dismissing alert
- message: The error message to be shown
- Returns: An UIAlertController with passed title and message
*/

func makeAlert(title: String, message: String, callback: @escaping () ->()) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
        alertController.dismiss(animated: true, completion: nil)
        callback()
    }
    alertController.addAction(dismissAction)
    return alertController
}


func makeScoreEditingClosedAlert(callback: @escaping () -> ()) -> UIAlertController {
    let title = "Score Editing Closed"
    let message = "Score editing is now closed. However you can still view the scores you submitted."
    return makeAlert(title: title, message: message, callback: callback)
}


func makeSubmissionClosedAlert(callback: @escaping () -> ()) -> UIAlertController {
    let title = "Score Submissions Closed"
    let message = "Score submissions are now closed. You can't submit any more new scores."
    return makeAlert(title: title, message: message, callback: callback)
}
