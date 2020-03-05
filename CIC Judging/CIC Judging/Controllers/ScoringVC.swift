//
//  ScoringVC.swift
//  CIC Judging
//
//  Created by Parth Tamane on 04/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ScoringVC: UIViewController {
    
    private let previousVCType: VCType
    private let teamId: Int
    private let teamInfo: TeamData
    private let judgeId = getUserPhoneNumber()
    
    private let headerVw = UIView()
    private let totalScoreLbl = UILabel()
    private var defaultTotalScore = 4
    private let scoringTblVw = UITableView()
    private var oldTblVwOffset = CGPoint(x: 0, y: 0)
    
    private let scoringCriterionList = [ScoringCriterion.Usability, ScoringCriterion.Innovation,  ScoringCriterion.Viability, ScoringCriterion.Presentation]
    private var scores: [String: Any] = [ScoringCriterion.Usability.rawValue: 1, ScoringCriterion.Innovation.rawValue: 1, ScoringCriterion.Viability.rawValue: 1, ScoringCriterion.Presentation.rawValue: 1, ScoringCriterion.Notes.rawValue: ""]
    
    
    init(previousVCType: VCType, teamId: Int, teamInfo: TeamData) {
        self.previousVCType = previousVCType
        self.teamId = teamId
        self.teamInfo = teamInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addHeaderView() {
        //Container
        view.addSubview(headerVw)
        headerVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
            infoStkVw.heightAnchor.constraint(equalToConstant: 80)
        ])
        //Team Logo
        let teamLogoImgVw = UIImageView()
        infoStkVw.addArrangedSubview(teamLogoImgVw)
        teamLogoImgVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamLogoImgVw.widthAnchor.constraint(equalToConstant: 80),
            teamLogoImgVw.centerYAnchor.constraint(equalTo: infoStkVw.centerYAnchor)
        ])
        teamLogoImgVw.contentMode = .scaleAspectFit
        downloadAndSetImage(for: teamLogoImgVw, from: teamInfo.logoUrl)
        //Project Name
        let projectNameLbl = UILabel()
        infoStkVw.addArrangedSubview(projectNameLbl)
        projectNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            projectNameLbl.heightAnchor.constraint(equalToConstant: 50),
            projectNameLbl.centerYAnchor.constraint(equalTo: infoStkVw.centerYAnchor)
        ])
        projectNameLbl.text = teamInfo.teamName
        projectNameLbl.font = headerFontBoldBig
        projectNameLbl.textColor = .white
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
        totalScoreLbl.text = String(defaultTotalScore)
        totalScoreLbl.font = headerFontRegular
        totalScoreLbl.textColor = .white
        //Dismiss Button
        let dismissBtn = UIButton()
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
        dismissBtn.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
        //Details Button
        let detailsBtn = UIButton()
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
    
    func addScoringTblVw() {
        fetchPreviousScores()
        scoringTblVw.estimatedRowHeight = 100
        scoringTblVw.rowHeight = UITableView.automaticDimension
        scoringTblVw.separatorStyle = UITableViewCell.SeparatorStyle.none
        scoringTblVw.delegate = self
        scoringTblVw.dataSource = self
        view.addSubview(scoringTblVw)
        scoringTblVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoringTblVw.topAnchor.constraint(equalTo: headerVw.bottomAnchor),
            scoringTblVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scoringTblVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scoringTblVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func makeSubmitCell() -> UITableViewCell {
        let submitCell = UITableViewCell()
        let submitButton = UIButton()
        submitCell.contentView.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: submitCell.contentView.topAnchor, constant: 10),
            submitButton.bottomAnchor.constraint(equalTo: submitCell.contentView.bottomAnchor, constant: -10),
            submitButton.leadingAnchor.constraint(equalTo: submitCell.contentView.leadingAnchor, constant: 10),
            submitButton.trailingAnchor.constraint(equalTo: submitCell.contentView.trailingAnchor, constant: -10),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        submitButton.backgroundColor = techGold
        submitButton.layer.cornerRadius = 5
        submitButton.layer.masksToBounds = true
        submitButton.setTitle("SUBMIT SCORES", for: .normal)
        submitButton.titleLabel?.font = headerFontBoldBig
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitScores(_:)), for: .touchUpInside)
        return submitCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addHeaderView()
        addScoringTblVw()
        registerForKeyboardNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(manageScoreUpdate(_:) ), name: NSNotification.Name(rawValue: scoreUpdateNotificationKey), object: nil)

    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func manageScoreUpdate(_ notification: NSNotification) {
        let scoreCriterion = Array(notification.userInfo!.keys).first as! String
        if let newScore = notification.userInfo![scoreCriterion] as? Int {
            scores[scoreCriterion] = newScore
            let newTotalScore = (scores[ScoringCriterion.Innovation.rawValue] as! Int) + (scores[ScoringCriterion.Usability.rawValue] as! Int) + (scores[ScoringCriterion.Presentation.rawValue] as! Int) + (scores[ScoringCriterion.Viability.rawValue] as! Int)
            totalScoreLbl.text = "\(newTotalScore)"
        } else if let newNote =  notification.userInfo![scoreCriterion] as? String {
            scores[scoreCriterion] = newNote
        }
    }
    
    func _dismissVC() {
        if previousVCType == .FilterAllTeamsVC || previousVCType == .FilterJudgedTeamsVC {
            presentingViewController?.view.isHidden = true
            presentingViewController?.view.backgroundColor = .clear
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissVC(_ sender: UIButton) {
        _dismissVC()
    }
    
    @objc func submitScores(_ sender: UIButton) {
        let ref = Database.database().reference()
        ref.child(teamsKey).child(String(teamInfo.teamId)).child(scoresKey).child(getUserPhoneNumber()).setValue(scores)
        _dismissVC()
    }
    
    func fetchPreviousScores() {
        let ref = Database.database().reference()
        let scoresRef = ref.child(teamsKey).child(String(teamInfo.teamId)).child(scoresKey).child(getUserPhoneNumber())
        scoresRef.observe(.value) { (snapshot) in
            do {
                if let value = snapshot.value {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let decodedScores =  try JSONDecoder().decode(ScoresData.self, from: data)
                    self.scores[ScoringCriterion.Usability.rawValue] = decodedScores.usability
                    self.scores[ScoringCriterion.Innovation.rawValue] = decodedScores.innovation
                    self.scores[ScoringCriterion.Presentation.rawValue] = decodedScores.presentation
                    self.scores[ScoringCriterion.Viability.rawValue] = decodedScores.viability
                    self.scores[ScoringCriterion.Notes.rawValue] = decodedScores.notes
                    self.scoringTblVw.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}


//MARK:- Scoring cell table view methods

extension ScoringVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoringCriterionList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 4 {
            let scoringCell = ScoringCell()
            scoringCell.configureCell(scoringCriterion: scoringCriterionList[indexPath.row], initialScore: scores[scoringCriterionList[indexPath.row].rawValue] as? Int ?? 1)
            return scoringCell
        } else if indexPath.row == 4 {
            //Notes Cell
            let notesCell = NotesCell()
            notesCell.configureCell(noteText: scores[ScoringCriterion.Notes.rawValue] as? String ?? "")
            return notesCell
        } else if indexPath.row == 5 {
            //Submit Cell
            return makeSubmitCell()
        }
        
        return UITableViewCell()
    }
}

extension ScoringVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- Handling text fields hidden by keyboard
extension ScoringVC {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func onKeyboardAppear(_ notification: NSNotification) {
        oldTblVwOffset = scoringTblVw.contentOffset
        DispatchQueue.main.async {
            let scrollPoint = CGPoint(x: 0, y: 450)
            self.scoringTblVw.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
//        scoringTblVw.setContentOffset(oldTblVwOffset, animated: true)
    }
}
