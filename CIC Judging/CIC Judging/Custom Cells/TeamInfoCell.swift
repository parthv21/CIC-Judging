//
//  TeamInfoCell.swift
//  CIC Judging
//
//  Created by Parth Tamane on 01/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class TeamInfoCell: UITableViewCell {
    
    private let teamLogoImgVw = UIImageView()
    private let teamNameLbl = UILabel()
    private let teamIdLbl = UILabel()
    private let teamScoreLbl = UILabel()
    private let cellToggleBtn = UIButton()
    private let container = UIStackView()
    private let scoreInfoStckkVw = UIStackView()
    
    private let defaultTeamName = "-"
    private let defaultTeamId = "Team ID: -"
    private let defaultScore = "Score: 0"
    
    private let isCollapsed = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Container
        let borderView = UIView()
        contentView.addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        borderView.layer.cornerRadius = 5
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.black.cgColor

        borderView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -10),
            container.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -10)
        ])
        //Top StackView
        let infoStckVw = UIStackView()
        container.addArrangedSubview(infoStckVw)
        infoStckVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStckVw.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            infoStckVw.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            infoStckVw.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
        ])
        infoStckVw.axis = .horizontal
        infoStckVw.distribution = .equalSpacing
        //Team Logo
        infoStckVw.addArrangedSubview(teamLogoImgVw)
        teamLogoImgVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamLogoImgVw.leadingAnchor.constraint(equalTo: infoStckVw.leadingAnchor, constant: 10),
            teamLogoImgVw.centerYAnchor.constraint(equalTo: infoStckVw.centerYAnchor),
            teamLogoImgVw.widthAnchor.constraint(equalToConstant: 30),
            teamLogoImgVw.heightAnchor.constraint(equalToConstant: 30)
        ])
        teamLogoImgVw.image = UIImage(named: "cic_logo")
        teamLogoImgVw.contentMode = .scaleAspectFit
        //Team name and ID
        let teamIdInfoStckVw = UIStackView()
        infoStckVw.addArrangedSubview(teamIdInfoStckVw)
        teamIdInfoStckVw.translatesAutoresizingMaskIntoConstraints = false
        teamIdInfoStckVw.axis = .vertical
        teamIdInfoStckVw.distribution = .equalSpacing
        teamIdInfoStckVw.spacing = 10
        NSLayoutConstraint.activate([
            teamIdInfoStckVw.leadingAnchor.constraint(equalTo: teamLogoImgVw.trailingAnchor, constant: 10),
            teamIdInfoStckVw.topAnchor.constraint(equalTo: infoStckVw.topAnchor, constant: 10),
            teamIdInfoStckVw.bottomAnchor.constraint(equalTo: infoStckVw.bottomAnchor, constant: 0),
        ])
        //Team Name
        teamIdInfoStckVw.addArrangedSubview(teamNameLbl)
        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            teamNameLbl.leadingAnchor.constraint(equalTo: teamIdInfoStackView.leadingAnchor),
//            teamNameLbl.trailingAnchor.constraint(equalTo: teamIdInfoStackView.trailingAnchor),
            teamNameLbl.topAnchor.constraint(equalTo: teamIdInfoStckVw.topAnchor, constant: 0),
            teamNameLbl.heightAnchor.constraint(equalToConstant: 50)
        ])
        teamNameLbl.text = defaultTeamName
        teamNameLbl.font = headerFontBold
        //Team ID
        
        teamIdInfoStckVw.addArrangedSubview(teamIdLbl)
        teamIdLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            teamIdLbl.leadingAnchor.constraint(equalTo: teamIdInfoStackView.leadingAnchor),
//            teamIdLbl.trailingAnchor.constraint(equalTo: teamIdInfoStackView.trailingAnchor),
            teamIdLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor, constant: 10),
            teamIdLbl.heightAnchor.constraint(equalToConstant: 20),
            teamIdLbl.bottomAnchor.constraint(equalTo: teamIdInfoStckVw.bottomAnchor, constant: 0)
        ])
        teamIdLbl.text = defaultTeamId
        teamIdLbl.font = contentFontRegular
        
        //Toggle Button
        infoStckVw.addArrangedSubview(cellToggleBtn)
        cellToggleBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellToggleBtn.widthAnchor.constraint(equalToConstant: 30),
            cellToggleBtn.heightAnchor.constraint(equalToConstant: 30),
//            cellToggleBtn.leadingAnchor.constraint(equalTo: teamIdInfoStckVw.trailingAnchor, constant: 10),
//            cellToggleBtn.trailingAnchor.constraint(equalTo: infoStckVw.trailingAnchor, constant: -10),
            cellToggleBtn.centerYAnchor.constraint(equalTo: teamIdInfoStckVw.centerYAnchor)
        ])
        cellToggleBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cellToggleBtn.setTitle(String.fontAwesomeIcon(name: .arrowDown), for: .normal)
        cellToggleBtn.setTitleColor(.black, for: .normal)
        //Score Info
        container.addArrangedSubview(scoreInfoStckkVw)
        scoreInfoStckkVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreInfoStckkVw.topAnchor.constraint(equalTo: infoStckVw.bottomAnchor, constant: 10),
            scoreInfoStckkVw.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            scoreInfoStckkVw.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            scoreInfoStckkVw.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
        scoreInfoStckkVw.axis = .vertical
        scoreInfoStckkVw.distribution = .equalSpacing
        //Seperator
        let seperator = UIView()
        scoreInfoStckkVw.addArrangedSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: scoreInfoStckkVw.topAnchor),
            seperator.leadingAnchor.constraint(equalTo: scoreInfoStckkVw.leadingAnchor, constant: 10),
            seperator.trailingAnchor.constraint(equalTo: scoreInfoStckkVw.trailingAnchor, constant: -10),
            seperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        seperator.backgroundColor = .black
        //Score
        scoreInfoStckkVw.addArrangedSubview(teamScoreLbl)
        teamScoreLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamScoreLbl.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 5),
            teamScoreLbl.bottomAnchor.constraint(equalTo: scoreInfoStckkVw.bottomAnchor, constant: -10),
            teamScoreLbl.leadingAnchor.constraint(equalTo: scoreInfoStckkVw.leadingAnchor, constant: 10),
            teamScoreLbl.trailingAnchor.constraint(equalTo: scoreInfoStckkVw.trailingAnchor, constant: -10),
            teamScoreLbl.heightAnchor.constraint(equalToConstant: 20)
        ])
        teamScoreLbl.textColor = .black
        teamScoreLbl.font = contentFontRegular
        teamScoreLbl.text = defaultScore
    }
    
    func configureCell(teamInfo: TeamData) {
        teamNameLbl.text = teamInfo.teamName
        teamIdLbl.text = "Team ID: \(teamInfo.teamId)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
