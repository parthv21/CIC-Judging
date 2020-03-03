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
        selectionStyle = .none
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
        
        let infoStckVw = UIStackView()
        borderView.addSubview(infoStckVw)
        infoStckVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStckVw.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 10),
            infoStckVw.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10),
            infoStckVw.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -10),
            infoStckVw.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -10)
        ])
        infoStckVw.axis = .horizontal
        infoStckVw.distribution = .equalSpacing
//        infoStckVw.distribution = .equalSpacing
        //Team Logo
        infoStckVw.addArrangedSubview(teamLogoImgVw)
        teamLogoImgVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamLogoImgVw.leadingAnchor.constraint(equalTo: infoStckVw.leadingAnchor, constant: 0),
            teamLogoImgVw.centerYAnchor.constraint(equalTo: infoStckVw.centerYAnchor),
            teamLogoImgVw.widthAnchor.constraint(equalToConstant: 50),
//            teamLogoImgVw.heightAnchor.constraint(equalToConstant: 30)
        ])
        teamLogoImgVw.image = UIImage(named: "cic_logo")
        teamLogoImgVw.contentMode = .scaleAspectFit
        //Team name and ID
        let teamIdInfoStckVw = UIStackView()
        infoStckVw.addArrangedSubview(teamIdInfoStckVw)
        teamIdInfoStckVw.translatesAutoresizingMaskIntoConstraints = false
        teamIdInfoStckVw.axis = .vertical
        teamIdInfoStckVw.distribution = .fillProportionally
        NSLayoutConstraint.activate([
            teamIdInfoStckVw.leadingAnchor.constraint(equalTo: teamLogoImgVw.trailingAnchor, constant: 20),
            teamIdInfoStckVw.topAnchor.constraint(equalTo: infoStckVw.topAnchor, constant: 0),
            teamIdInfoStckVw.bottomAnchor.constraint(equalTo: infoStckVw.bottomAnchor, constant: 0),
            teamIdInfoStckVw.trailingAnchor.constraint(equalTo: infoStckVw.trailingAnchor, constant: 0)
        ])
        //Team Name
        teamIdInfoStckVw.addArrangedSubview(teamNameLbl)
        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            teamNameLbl.leadingAnchor.constraint(equalTo: teamIdInfoStackView.leadingAnchor),
//            teamNameLbl.trailingAnchor.constraint(equalTo: teamIdInfoStackView.trailingAnchor),
//            teamNameLbl.topAnchor.constraint(equalTo: teamIdInfoStckVw.topAnchor, constant: 0),
            teamNameLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
        teamNameLbl.text = defaultTeamName
        teamNameLbl.font = headerFontBold
        teamNameLbl.textColor = .black
        //Team ID
        
        teamIdInfoStckVw.addArrangedSubview(teamIdLbl)
        teamIdLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            teamIdLbl.leadingAnchor.constraint(equalTo: teamIdInfoStackView.leadingAnchor),
//            teamIdLbl.trailingAnchor.constraint(equalTo: teamIdInfoStackView.trailingAnchor),
            teamIdLbl.topAnchor.constraint(equalTo: teamNameLbl.bottomAnchor, constant: 0),
            teamIdLbl.heightAnchor.constraint(equalToConstant: 20),
            teamIdLbl.bottomAnchor.constraint(equalTo: teamIdInfoStckVw.bottomAnchor, constant: 0)
        ])
        teamIdLbl.text = defaultTeamId
        teamIdLbl.font = contentFontRegular
        teamIdLbl.textColor = .black
//        teamIdLbl.isHidden = true
    }
    
    func configureCell(teamInfo: TeamData) {
        teamNameLbl.text = teamInfo.teamName
        teamIdLbl.text = "Team ID: \(teamInfo.teamId)"
        if teamLogoImages.index(forKey: teamInfo.logoUrl) != nil {
            teamLogoImgVw.image = teamLogoImages[teamInfo.logoUrl]
        } else {
            fetchImage(url: teamInfo.logoUrl) { (logo) in
                teamLogoImages[teamInfo.logoUrl] = logo
                DispatchQueue.main.async {
                    self.teamLogoImgVw.image = logo
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
