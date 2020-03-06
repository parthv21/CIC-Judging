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
    
    private let headerView = UIView()
    private let judgeNameLbl = UILabel()
    private let defaultJudegName = "Jon Doe"
    private let affinityGroupName = UILabel()
    private let defaultAffinityGroupName = "-"
    private let judgedCountBtn = UIButton()
    private let judgedCount = UILabel()
    private let defaultJudgedCount = "-"
    private let teamSearchBar = UISearchBar()
    private let teamListTblVw = UITableView()
    private var teams = [TeamData]()
    private var filteredTeams = [TeamData]()
    private  let titleLbl = UILabel()
    private lazy var functions = Functions.functions()
    
    func makeHeaderView() {
        //Header
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        headerView.backgroundColor = techGold
        //Judge Name
        headerView.addSubview(judgeNameLbl)
        judgeNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            judgeNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            judgeNameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            judgeNameLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            judgeNameLbl.heightAnchor.constraint(equalToConstant: 30)
        ])
        judgeNameLbl.textColor = .white
        judgeNameLbl.font = headerFontBoldBig
        judgeNameLbl.text = defaultJudegName
        //Seperator
        let seperator = UIView()
        headerView.addSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: judgeNameLbl.bottomAnchor, constant: 10),
            seperator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seperator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            seperator.heightAnchor.constraint(equalToConstant: 2)
        ])
        seperator.backgroundColor = .white
        //Affinity group
        let affinityGroupTitle = UILabel()
        headerView.addSubview(affinityGroupTitle)
        affinityGroupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            affinityGroupTitle.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 20),
            affinityGroupTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            affinityGroupTitle.heightAnchor.constraint(equalToConstant: 20),
            affinityGroupTitle.widthAnchor.constraint(equalToConstant: 80),
        ])
        affinityGroupTitle.textColor = .white
        affinityGroupTitle.text = "Affinity:"
        affinityGroupTitle.font = headerFontBold
        headerView.addSubview(affinityGroupName)
        affinityGroupName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            affinityGroupName.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 20),
            affinityGroupName.leadingAnchor.constraint(equalTo: affinityGroupTitle.trailingAnchor),
            affinityGroupName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            affinityGroupName.heightAnchor.constraint(equalToConstant: 20)
        ])
        affinityGroupName.textColor = .white
        affinityGroupName.font = headerFontRegular
        affinityGroupName.text = defaultAffinityGroupName
        
        
        /*
         
         //Judged Count
         let judgedCountTitle = UILabel()
         headerView.addSubview(judgedCountTitle)
         judgedCountTitle.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
         judgedCountTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
         judgedCountTitle.topAnchor.constraint(equalTo: affinityGroupTitle.bottomAnchor, constant: 10),
         judgedCountTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
         judgedCountTitle.heightAnchor.constraint(equalToConstant: 20),
         judgedCountTitle.widthAnchor.constraint(equalToConstant: 80)
         ])
         judgedCountTitle.textColor = .white
         judgedCountTitle.text = "Judged:"
         judgedCountTitle.font = headerFontBold
         headerView.addSubview(judgedCount)
         judgedCount.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
         judgedCount.topAnchor.constraint(equalTo: affinityGroupTitle.bottomAnchor, constant: 10),
         judgedCount.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
         judgedCount.leadingAnchor.constraint(equalTo: judgedCountTitle.trailingAnchor),
         judgedCount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
         judgedCount.heightAnchor.constraint(equalToConstant: 20),
         ])
         judgedCount.textColor = .white
         judgedCount.font = headerFontRegular
         judgedCount.text = defaultJudgedCount
         */
        
        //Judged Count
        headerView.addSubview(judgedCountBtn)
        judgedCountBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            judgedCountBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            judgedCountBtn.topAnchor.constraint(equalTo: affinityGroupTitle.bottomAnchor, constant: 20),
            judgedCountBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            judgedCountBtn.heightAnchor.constraint(equalToConstant: 30),
            judgedCountBtn.widthAnchor.constraint(equalToConstant: 150)
        ])
        judgedCountBtn.setTitleColor(.white, for: .normal)
        judgedCountBtn.titleLabel?.font = headerFontRegular
        self.judgedCountBtn.setTitle("Scored 0 Teams", for: .normal)
        judgedCountBtn.layer.cornerRadius = 5
        judgedCountBtn.layer.borderWidth = 1
        judgedCountBtn.layer.borderColor = UIColor.white.cgColor
        judgedCountBtn.addTarget(self, action: #selector(showScoredTeamsList(_:)), for: .touchUpInside)
        let ref = Database.database().reference()
        ref.child(judgesKey).child(getUserPhoneNumber()).child(judgedTeamsKey).observe(.value) { (snapshot) in
            if let teamIds = snapshot.value as? [Int] {
                self.judgedCountBtn.setTitle("Scored \(teamIds.count) Teams", for: .normal)
            } else {
                self.judgedCountBtn.setTitle("Scored 0 Teams", for: .normal)
            }
        }
        
        //Log Out
        let logOutBtn = UIButton()
        view.addSubview(logOutBtn)
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.titleLabel?.font = headerFontRegular
        logOutBtn.setTitleColor(.black, for: .normal)
        logOutBtn.layer.cornerRadius = 5
        logOutBtn.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            logOutBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logOutBtn.topAnchor.constraint(equalTo: affinityGroupTitle.bottomAnchor, constant: 20),
            logOutBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            logOutBtn.widthAnchor.constraint(equalToConstant: 80),
            logOutBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
        logOutBtn.addTarget(self, action: #selector(logOutUser(_:)), for: .touchUpInside)
    }
    
    func makeSearchTeamsCell() -> UITableViewCell {
        let searchCell = UITableViewCell()
        searchCell.selectionStyle = .none
        let searchBtn = UIButton()
        searchCell.contentView.addSubview(searchBtn)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: searchCell.contentView.topAnchor, constant: 10),
            searchBtn.heightAnchor.constraint(equalToConstant: 40),
            searchBtn.bottomAnchor.constraint(equalTo: searchCell.contentView.bottomAnchor, constant: -10),
            searchBtn.leadingAnchor.constraint(equalTo: searchCell.contentView.leadingAnchor, constant: 10),
            searchBtn.trailingAnchor.constraint(equalTo: searchCell.contentView.trailingAnchor, constant: -10),
        ])
        searchBtn.setTitle("Search Team", for: .normal)
        searchBtn.layer.cornerRadius = 5
        searchBtn.layer.borderWidth = 1
        searchBtn.layer.borderColor = UIColor.black.cgColor
        searchBtn.setTitleColor(.black, for: .normal)
        searchBtn.titleLabel?.font = UIFont(name: robotoRegular, size: 17)
        searchBtn.addTarget(self, action: #selector(showAllTeamsList(_:)), for: .touchUpInside)
        return searchCell
    }
    
    func setHeaderGroupLabels() {
        let phoneNumber = getUserPhoneNumber()
        let ref = Database.database().reference().child(judgesKey).child(phoneNumber)
        ref.child(judgeNameKey).observeSingleEvent(of: .value) { (snapshot) in
            self.judgeNameLbl.text = snapshot.value as? String ?? "-"
        }
        ref.child(affinityGroupKey).observeSingleEvent(of: .value) { (snapshot) in
            self.affinityGroupName.text = snapshot.value as? String ?? "-"
        }
        ref.child(judgedCountKey).observe(.value) { (snapshot) in
            self.judgedCount.text = String(snapshot.value as? Int ?? 0)
        }
    }
    
    func addVCTitle() {
        view.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
        titleLbl.text = "Please score any one team..."
        titleLbl.font = UIFont(name: robotoRegular, size: 18)
        titleLbl.textColor = .black
        titleLbl.textAlignment = .center
    }
    
    func addTeamListTblVw() {
        view.addSubview(teamListTblVw)
        teamListTblVw.delegate = self
        teamListTblVw.dataSource = self
        teamListTblVw.translatesAutoresizingMaskIntoConstraints = false
        teamListTblVw.estimatedRowHeight = 300
        teamListTblVw.rowHeight = UITableView.automaticDimension
        teamListTblVw.separatorStyle = UITableViewCell.SeparatorStyle.none
        NSLayoutConstraint.activate([
            teamListTblVw.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            teamListTblVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            teamListTblVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            teamListTblVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        teamListTblVw.backgroundColor = .white
    }
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        makeHeaderView()
        setHeaderGroupLabels()
        addVCTitle()
        addTeamListTblVw()
        fetchTeamData()
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
    
    @objc func showAllTeamsList(_ sender: UIButton) {
        let allTeamsListVC = FilterTeamsVC(filterVCType: .AllTeams)
        present(allTeamsListVC, animated: true)
    }
    
    @objc func showScoredTeamsList(_ sender: UIButton) {
        let judgedTeamsListVC = FilterTeamsVC(filterVCType: .JudgedTeams)
        present(judgedTeamsListVC, animated: true)
    }
}

//MARK:- Team list management functions
extension TeamListVC {
    func filterTeams(searchText: String) -> [TeamData] {
        if searchText == "" { return teams }
        
        var filteredTeams = [TeamData]()
        for team in teams {
            if let _ = team.teamName.range(of: searchText, options: .caseInsensitive) {
                filteredTeams.append(team)
            }
        }
        return filteredTeams
    }
}

//MARK:- Team Search Bar
extension TeamListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTeams = filterTeams(searchText: searchText)
        teamListTblVw.reloadData()
    }
}

//MARK:- Team List table view
extension TeamListVC: UITableViewDataSource {
    
    func fetchTeamData() {
        let ref = Database.database().reference()
        
        functions.httpsCallable("assignTeams").call(["judgeId": getUserPhoneNumber()]) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    print("Error: \(details)")
                }
            }
        }
        
        
        ref.child(judgingQueueKey).child(getUserPhoneNumber()).observe(.value) { (snapshot) in
            guard let value = snapshot.value else { return }
            let teamIds = value as? [Int]
            if let teamIds = teamIds {
                for teamId in teamIds {
                    ref.child(teamsKey).child(String(teamId)).observeSingleEvent(of: .value) { (snapshot) in
                        do {
                            let value = snapshot.value
                            let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                            let decodedTeam =  try JSONDecoder().decode(TeamData.self, from: data)
                            self.teams.append(decodedTeam)
                            self.filteredTeams.append(decodedTeam)
                            self.teamListTblVw.reloadData()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTeams.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == filteredTeams.count {
            return makeSearchTeamsCell()
        }
        
        let cell = TeamInfoCell()
        cell.configureCell(teamInfo: filteredTeams[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let teamInfo = filteredTeams[indexPath.row]
        let scoringVC = ScoringVC(previousVCType: .TeamListVC, teamId: teamInfo.teamId, teamInfo: teamInfo)
        present(scoringVC, animated: true, completion: nil)
    }
}

extension TeamListVC: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        teamSearchBar.endEditing(true)
    }
}
