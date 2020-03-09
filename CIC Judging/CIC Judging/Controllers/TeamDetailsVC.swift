//
//  TeamDetails.swift
//  CIC Judging
//
//  Created by Parth Tamane on 05/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

class TeamDetailsVC: UIViewController {
    
    private let teamInfo: TeamData
    private let totalScore: Int
    private let headerVw = UIView()
    private let totalScoreLbl = UILabel()
    
    init(teamInfo: TeamData, totalScore: Int) {
        self.teamInfo = teamInfo
        self.totalScore = totalScore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHeaderView() {
        view.addSubview(headerVw)
        let dismissBtn = UIButton()
        NSLayoutConstraint.activate([
                   headerVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   headerVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                   headerVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
               ])
        makeInfoHeaderView(view: view, headerVw: headerVw, teamInfo: teamInfo, totalScoreLbl: totalScoreLbl, detailsBtn: nil, dismissBtn: dismissBtn)
        
        totalScoreLbl.text = String(totalScore)
        dismissBtn.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
        headerVw.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addInfoTxtVw() {
        let infoTxtVw = UITextView()
        view.addSubview(infoTxtVw)
        infoTxtVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoTxtVw.topAnchor.constraint(equalTo: headerVw.bottomAnchor),
            infoTxtVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            infoTxtVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -10),
            infoTxtVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        infoTxtVw.isEditable = false
        let detailsAtrTxt = NSMutableAttributedString()
        detailsAtrTxt.append(getBoldFont(text: "Members\n\n"))
        for teamMember in teamInfo.team {
            detailsAtrTxt.append(getRegularFont(text: "• \(teamMember)\n"))
        }
        detailsAtrTxt.append(getBoldFont(text: "\n\nDescription\n\n"))
        detailsAtrTxt.append(getRegularFont(text: teamInfo.descp))
        infoTxtVw.attributedText = detailsAtrTxt
    }
    
    func _dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissVC(_ sender: UIButton) {
        _dismissVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addHeaderView()
        addInfoTxtVw()
    }
}
