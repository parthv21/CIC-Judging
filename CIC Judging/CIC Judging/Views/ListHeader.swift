//
//  ListHeader.swift
//  CIC Judging
//
//  Created by Parth Tamane on 10/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

func makeListHeader(view: UIView, headerVw: UIView, title: String, dismissBtn: UIButton) {
    view.addSubview(headerVw)
    headerVw.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        headerVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        headerVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        headerVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
    //Title
    let titleLbl = UILabel()
    headerVw.addSubview(titleLbl)
    titleLbl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        titleLbl.topAnchor.constraint(equalTo: headerVw.topAnchor, constant: 10),
        titleLbl.bottomAnchor.constraint(equalTo: headerVw.bottomAnchor, constant: -10),
        titleLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        titleLbl.heightAnchor.constraint(equalToConstant: 40),
        titleLbl.widthAnchor.constraint(equalToConstant: 150)
    ])
    titleLbl.text = title
    titleLbl.textColor = .black
    titleLbl.font = UIFont(name: robotoBold, size: 18)
    //Dismiss Button
    headerVw.addSubview(dismissBtn)
    dismissBtn.translatesAutoresizingMaskIntoConstraints = false
    dismissBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
    dismissBtn.setTitle(String.fontAwesomeIcon(name: .timesCircle), for: .normal)
    NSLayoutConstraint.activate([
        dismissBtn.heightAnchor.constraint(equalToConstant: 50),
        dismissBtn.widthAnchor.constraint(equalToConstant: 50),
        dismissBtn.trailingAnchor.constraint(equalTo: headerVw.trailingAnchor, constant: -10),
        dismissBtn.centerYAnchor.constraint(equalTo: headerVw.centerYAnchor)
    ])
    dismissBtn.setTitleColor(.black, for: .normal)
}
