//
//  ScoringCell.swift
//  CIC Judging
//
//  Created by Parth Tamane on 04/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

class ScoringCell: UITableViewCell {
    
    private var scoringCriterion: ScoringCriterion = .Innovation
    private let scoringCriterionTitleLbl = UILabel()
    private let scoreLbl = UILabel()
    private let scoringBtnStkVw = UIStackView()
    private var score = 1
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Container
        let container = UIView()
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.masksToBounds = true
        container.layer.borderColor = UIColor.black.cgColor
        //Title
        container.addSubview(scoringCriterionTitleLbl)
        scoringCriterionTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoringCriterionTitleLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            scoringCriterionTitleLbl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            scoringCriterionTitleLbl.heightAnchor.constraint(equalToConstant: 30),
            scoringCriterionTitleLbl.widthAnchor.constraint(equalToConstant: 100)
        ])
        scoringCriterionTitleLbl.font = contentFontBold
        scoringCriterionTitleLbl.textColor = .black
        //Score
        container.addSubview(scoreLbl)
        scoreLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            scoreLbl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            scoreLbl.heightAnchor.constraint(equalToConstant: 30),
            scoreLbl.widthAnchor.constraint(equalToConstant: 50)
        ])
        scoreLbl.font = contentFontBold
        scoreLbl.textColor = .black
        //Score Buttons Stackview
        container.addSubview(scoringBtnStkVw)
        scoringBtnStkVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoringBtnStkVw.heightAnchor.constraint(equalToConstant: 40),
            scoringBtnStkVw.widthAnchor.constraint(equalToConstant: 240),
            scoringBtnStkVw.topAnchor.constraint(equalTo: scoringCriterionTitleLbl.bottomAnchor, constant: 10),
            scoringBtnStkVw.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            scoringBtnStkVw.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        scoringBtnStkVw.axis = .horizontal
        scoringBtnStkVw.distribution = .fillEqually
        scoringBtnStkVw.distribution = .fillEqually
        
        //Scoring Buttons
        let scoreOneBtn = makeScoreButton(title: 1, fontSize: 12, height: 40)
        scoringBtnStkVw.addArrangedSubview(scoreOneBtn)
        let scoreTwoBtn = makeScoreButton(title: 2, fontSize: 14, height: 40)
        scoringBtnStkVw.addArrangedSubview(scoreTwoBtn)
        let scoreThreeBtn = makeScoreButton(title: 3, fontSize: 16, height: 40)
        scoringBtnStkVw.addArrangedSubview(scoreThreeBtn)
        let scoreFourBtn = makeScoreButton(title: 4, fontSize: 18, height: 40)
        scoringBtnStkVw.addArrangedSubview(scoreFourBtn)
        let scoreFiveBtn = makeScoreButton(title: 5, fontSize: 20, height: 40)
        scoringBtnStkVw.addArrangedSubview(scoreFiveBtn)

    }
    
    func makeScoreButton(title: Int, fontSize: Int, height: Int) -> UIButton {
        let scoreBtn = UIButton()
        scoreBtn.setTitle(String(title), for: .normal)
        scoreBtn.setTitleColor(.black, for: .normal)
        scoreBtn.titleLabel?.font = UIFont(name: robotoRegular, size: CGFloat(fontSize))
        scoreBtn.tag = title
        scoreBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreBtn.widthAnchor.constraint(equalToConstant: CGFloat(height))
        ])
        scoreBtn.layer.cornerRadius = CGFloat(height/2)
        scoreBtn.addTarget(self, action: #selector(broadcastScore(_:)), for: .touchUpInside)
        return scoreBtn
    }
    
    func configureCell(scoringCriterion: ScoringCriterion, initialScore: Int) {
        self.scoringCriterion = scoringCriterion
        self.score = initialScore
        self.scoringCriterionTitleLbl.text = self.scoringCriterion.rawValue.capitalized
        self.scoreLbl.text = "\(initialScore)/5"
        scoringBtnStkVw.viewWithTag(initialScore)?.backgroundColor = techGold
    }
    
    @objc func broadcastScore(_ sender: UIButton) {
        let newScore = sender.tag
        scoringBtnStkVw.viewWithTag(score)?.backgroundColor = .clear
        scoringBtnStkVw.viewWithTag(newScore)?.backgroundColor = techGold
        score = newScore
        scoreLbl.text = "\(newScore)/5"
        let notificationName = NSNotification.Name(rawValue: scoreUpdateNotificationKey)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [scoringCriterion.rawValue: newScore])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
