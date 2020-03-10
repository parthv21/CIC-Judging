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
    private lazy var functions = Functions.functions()
    private var isKeyboardVisible = false
    
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
        view.addSubview(headerVw)
        let dismissBtn = UIButton()
        let detailsBtn = UIButton()
        NSLayoutConstraint.activate([
            headerVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        makeInfoHeaderView(view: view, headerVw: headerVw, teamInfo: teamInfo, totalScoreLbl: totalScoreLbl, detailsBtn: detailsBtn, dismissBtn: dismissBtn)
        
        totalScoreLbl.text = String(defaultTotalScore)
        dismissBtn.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
        detailsBtn.addTarget(self, action: #selector(presentTeamDetails(_:)), for: .touchUpInside)
        headerVw.translatesAutoresizingMaskIntoConstraints = false
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
            let newTotalScore = calculateTotalScore()
            totalScoreLbl.text = "\(newTotalScore)"
        } else if let newNote =  notification.userInfo![scoreCriterion] as? String {
            scores[scoreCriterion] = newNote
        }
    }
    
    func calculateTotalScore() -> Int {
        return (scores[ScoringCriterion.Innovation.rawValue] as! Int)
            + (scores[ScoringCriterion.Usability.rawValue] as! Int)
            + (scores[ScoringCriterion.Presentation.rawValue] as! Int)
            + (scores[ScoringCriterion.Viability.rawValue] as! Int)
    }
    
    func _dismissVC() {
        if previousVCType == .FilterAllTeamsVC || previousVCType == .FilterJudgedTeamsVC {
            //presentingViewController?.view.isHidden = true
            //presentingViewController?.view.backgroundColor = .clear
            //presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissVC(_ sender: UIButton) {
        _dismissVC()
    }
    
    @objc func presentTeamDetails(_ sender: UIButton) {
        let teamDetailsVC = TeamDetailsVC(teamInfo: teamInfo, totalScore: Int(totalScoreLbl.text ?? "0") ?? 0)
        present(teamDetailsVC, animated: true, completion: nil)
    }
    
    @objc func submitScores(_ sender: UIButton) {
        let ref = Database.database().reference()
        ref.child(scoresKey).child(String(teamInfo.teamId)).child(getUserPhoneNumber()).setValue(scores)
        ref.child(judgedTeamsKey).child(getUserPhoneNumber()).childByAutoId().setValue(teamId)
        functions.httpsCallable("removeAssignedTeam").call(["judgeId": getUserPhoneNumber(), "teamId": teamId]) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    //                    let code = FunctionsErrorCode(rawValue: error.code)
                    //                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    print("Error Remvoing Team: \(details)")
                }
            }
//            else {
//                self.functions.httpsCallable("assignTeams").call(["judgeId": getUserPhoneNumber()]) { (result, error) in
//                    if let error = error as NSError? {
//                        if error.domain == FunctionsErrorDomain {
//                            let details = error.userInfo[FunctionsErrorDetailsKey]
//                            print("Error Assigning New Team: \(details)")
//                        }
//                    }
//                }
//            }
        }
        
        _dismissVC()
    }
    
    func fetchPreviousScores() {
        let ref = Database.database().reference()
        let scoresRef = ref.child(scoresKey).child(String(teamInfo.teamId)).child(getUserPhoneNumber())
        scoresRef.observe(.value) { (snapshot) in
            if !snapshot.exists() { return }
            do {
                if let value = snapshot.value {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let decodedScores =  try JSONDecoder().decode(ScoresData.self, from: data)
                    self.scores[ScoringCriterion.Usability.rawValue] = decodedScores.usability
                    self.scores[ScoringCriterion.Innovation.rawValue] = decodedScores.innovation
                    self.scores[ScoringCriterion.Presentation.rawValue] = decodedScores.presentation
                    self.scores[ScoringCriterion.Viability.rawValue] = decodedScores.viability
                    self.scores[ScoringCriterion.Notes.rawValue] = decodedScores.notes
                    self.defaultTotalScore = self.calculateTotalScore()
                    self.totalScoreLbl.text = "\(self.defaultTotalScore)"
                    self.scoringTblVw.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}


//MARK:- Scoring cell table view configuration

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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isKeyboardVisible {
            isKeyboardVisible = false
            view.endEditing(true)
        }
    }
    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        isKeyboardVisible = true
//    }
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
            UIView.animate(withDuration: 0.5, animations: {
                let scrollPoint = CGPoint(x: 0, y: 450)
                self.scoringTblVw.contentOffset = scrollPoint
            }) { (finished) in
                if finished {
                    self.isKeyboardVisible = true
                }
            }
        }
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scoringTblVw.setContentOffset(oldTblVwOffset, animated: true)
    }
}
