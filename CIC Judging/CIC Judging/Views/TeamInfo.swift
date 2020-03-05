//
//  TeamInfo.swift
//  CIC Judging
//
//  Created by Parth Tamane on 05/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

func makeInfoHeaderView(view: UIView, headerVw: UIView, teamInfo: TeamData, totalScoreLbl: UILabel, detailsBtn: UIButton?, dismissBtn: UIButton) {
    
    headerVw.backgroundColor = techGold
    //Horizontal Stack View
    let infoStkVw = UIStackView()
    headerVw.addSubview(infoStkVw)
    infoStkVw.translatesAutoresizingMaskIntoConstraints = false
    infoStkVw.axis = .horizontal
    infoStkVw.spacing = 10
    infoStkVw.distribution = .fillProportionally
    NSLayoutConstraint.activate([
        infoStkVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        infoStkVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        infoStkVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        infoStkVw.heightAnchor.constraint(equalToConstant: 120)
    ])
    //Team Logo
    let teamLogoImgVw = UIImageView()
    infoStkVw.addArrangedSubview(teamLogoImgVw)
    teamLogoImgVw.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        teamLogoImgVw.widthAnchor.constraint(equalToConstant: 120),
        teamLogoImgVw.centerYAnchor.constraint(equalTo: infoStkVw.centerYAnchor)
    ])
    teamLogoImgVw.contentMode = .scaleAspectFit
    downloadAndSetImage(for: teamLogoImgVw, from: teamInfo.logoUrl)
    //Team Details Stackview
    let teamDetailsStkVw = UIStackView()
    infoStkVw.addArrangedSubview(teamDetailsStkVw)
    teamDetailsStkVw.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        teamDetailsStkVw.topAnchor.constraint(equalTo: infoStkVw.topAnchor, constant: 10),
        teamDetailsStkVw.bottomAnchor.constraint(equalTo: infoStkVw.bottomAnchor, constant: -10)
    ])
    teamDetailsStkVw.axis = .vertical
    teamDetailsStkVw.spacing = 10
    //Project Name
    let projectNameLbl = UILabel()
    teamDetailsStkVw.addArrangedSubview(projectNameLbl)
    projectNameLbl.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        //            projectNameLbl.heightAnchor.constraint(equalToConstant: 50),
//        projectNameLbl.centerYAnchor.constraint(equalTo: infoStkVw.centerYAnchor)
//    ])
    projectNameLbl.text = teamInfo.teamName
    projectNameLbl.font = headerFontBoldBig
    projectNameLbl.textColor = .white
    //Project Category
    let projectCategoryLbl = UILabel()
    teamDetailsStkVw.addArrangedSubview(projectCategoryLbl)
    projectCategoryLbl.translatesAutoresizingMaskIntoConstraints = false
    projectCategoryLbl.text = teamInfo.affinityGroup
    projectCategoryLbl.font = contentFontRegular
    projectCategoryLbl.textColor = .white
    //Team ID
    let projectIDLbl = UILabel()
    teamDetailsStkVw.addArrangedSubview(projectIDLbl)
    projectIDLbl.translatesAutoresizingMaskIntoConstraints = false
    projectIDLbl.text = "Team ID: \(teamInfo.teamId)"
    projectIDLbl.font = contentFontRegular
    projectIDLbl.textColor = .white
    //Score
    let totalScoreTitleLbl = UILabel()
    headerVw.addSubview(totalScoreTitleLbl)
    totalScoreTitleLbl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        totalScoreTitleLbl.topAnchor.constraint(equalTo: infoStkVw.bottomAnchor, constant: 10),
        totalScoreTitleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        totalScoreTitleLbl.heightAnchor.constraint(equalToConstant: 30),
        totalScoreTitleLbl.bottomAnchor.constraint(equalTo: headerVw.bottomAnchor, constant: -10)
    ])
    totalScoreTitleLbl.text = "Score"
    totalScoreTitleLbl.font = headerFontBold
    totalScoreTitleLbl.textColor = .white
    //Total Score
    headerVw.addSubview(totalScoreLbl)
    totalScoreLbl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        totalScoreLbl.topAnchor.constraint(equalTo: infoStkVw.bottomAnchor, constant: 10),
        totalScoreLbl.leadingAnchor.constraint(equalTo: totalScoreTitleLbl.trailingAnchor, constant: 10),
        totalScoreLbl.heightAnchor.constraint(equalToConstant: 30),
        totalScoreLbl.bottomAnchor.constraint(equalTo: headerVw.bottomAnchor, constant: -10)
    ])
    totalScoreLbl.font = headerFontRegular
    totalScoreLbl.textColor = .white
    //Dismiss Button
    headerVw.addSubview(dismissBtn)
    dismissBtn.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        dismissBtn.topAnchor.constraint(equalTo: infoStkVw.bottomAnchor, constant: 10),
        dismissBtn.bottomAnchor.constraint(equalTo: headerVw.bottomAnchor, constant: -10),
        dismissBtn.trailingAnchor.constraint(equalTo: headerVw.trailingAnchor, constant: -10),
        dismissBtn.widthAnchor.constraint(equalToConstant: 30),
        dismissBtn.heightAnchor.constraint(equalToConstant: 30),
    ])
    dismissBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
    dismissBtn.setTitle(String.fontAwesomeIcon(name: .timesCircle), for: .normal)
    dismissBtn.setTitleColor(.black, for: .normal)
    //Details Button
    if let detailsBtn = detailsBtn {
        headerVw.addSubview(detailsBtn)
        detailsBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsBtn.topAnchor.constraint(equalTo: infoStkVw.bottomAnchor, constant: 10),
            detailsBtn.bottomAnchor.constraint(equalTo: headerVw.bottomAnchor, constant: -10),
            detailsBtn.trailingAnchor.constraint(equalTo: dismissBtn.leadingAnchor, constant: -10),
            detailsBtn.heightAnchor.constraint(equalToConstant: 30),
            detailsBtn.widthAnchor.constraint(equalToConstant: 80)
        ])
        detailsBtn.setTitle("Details", for: .normal)
        detailsBtn.setTitleColor(.black, for: .normal)
        detailsBtn.titleLabel?.font = headerFontRegular
        detailsBtn.layer.cornerRadius = 5
        detailsBtn.layer.borderWidth = 1
        detailsBtn.layer.borderColor = UIColor.black.cgColor
        detailsBtn.layer.masksToBounds = true
    }
}
