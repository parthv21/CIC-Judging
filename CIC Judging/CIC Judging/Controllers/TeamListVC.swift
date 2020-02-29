//
//  TeamListVC.swift
//  CIC Judging
//
//  Created by Parth Tamane on 29/02/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TeamListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        let logOutBtn = UIButton()
        view.addSubview(logOutBtn)
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.setTitle("Log Out", for: .normal)
        NSLayoutConstraint.activate([
            logOutBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logOutBtn.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            logOutBtn.widthAnchor.constraint(equalToConstant: 100),
            logOutBtn.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        logOutBtn.addTarget(self, action: #selector(logOutUser(_:)), for: .touchUpInside)
    }
    
    @objc func logOutUser(_ sender: UIButton) {
        do {
          try Auth.auth().signOut()
            let loginVc = LoginVC()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: true, completion: nil)
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey: authVerificationID)
            prefs.removeObject(forKey: hasRunBefore)

        } catch let signOutError as NSError {
            let signOutErrorAlrt = makeAlert(title: "Sign Out Error", message: signOutError.localizedDescription)
            present(signOutErrorAlrt, animated: true, completion: nil)
        }
    }
}
