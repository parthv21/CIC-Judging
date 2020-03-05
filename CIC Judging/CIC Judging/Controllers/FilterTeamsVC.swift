//
//  FilterTeamsVC.swift
//  CIC Judging
//
//  Created by Parth Tamane on 03/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
import Firebase

class FilterTeamsVC: UIViewController {
    
    private var teams = [TeamData]()
    private var filteredTeams = [TeamData]()
    private let teamSearchBar = UISearchBar()
    private let headerView = UIView()
    private var filterVCType: FilterVCType
    private let teamListTblVw = UITableView()
    
    init(filterVCType: FilterVCType) {
        self.filterVCType = filterVCType
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHeader() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        //Title
        let titleLbl = UILabel()
        headerView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLbl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            titleLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLbl.heightAnchor.constraint(equalToConstant: 40),
            titleLbl.widthAnchor.constraint(equalToConstant: 150)
        ])
        titleLbl.text = filterVCType.rawValue
        titleLbl.textColor = .black
        titleLbl.font = UIFont(name: robotoBold, size: 18)
        //Dismiss Button
        let dismissBtn = UIButton()
        headerView.addSubview(dismissBtn)
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        dismissBtn.setTitle(String.fontAwesomeIcon(name: .timesCircle), for: .normal)
        NSLayoutConstraint.activate([
            dismissBtn.heightAnchor.constraint(equalToConstant: 30),
            dismissBtn.widthAnchor.constraint(equalToConstant: 30),
            dismissBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            dismissBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        dismissBtn.setTitleColor(.black, for: .normal)
        dismissBtn.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
    }
    
    func addSearchBar() {
        view.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamSearchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            teamSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            teamSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        teamSearchBar.placeholder = "Filter teams..."
        teamSearchBar.delegate = self
    }
    
    func addTeamListTblVw() {
        view.addSubview(teamListTblVw)
        teamListTblVw.delegate = self
        teamListTblVw.dataSource = self
        teamListTblVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamListTblVw.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 0),
            teamListTblVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            teamListTblVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            teamListTblVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func fetchTeamsList() {
        let ref = Database.database().reference()
        switch filterVCType {
        case .AllTeams:
            ref.child(teamsKey).observeSingleEvent(of: .value) { (snapshot) in
                do {
                    let value = snapshot.value
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let decodedTeams =  try JSONDecoder().decode([Int: TeamData].self, from: data)
                    self.teams = decodedTeams.map{ $0.1 }
                    self.filteredTeams = self.teams
                    self.teamListTblVw.reloadData()
                } catch {
                    print(error)
                }
            }
        case .JudgedTeams:
            ref.child(judgesKey).child(getUserPhoneNumber()).child(judgedTeamsKey).observe(.value) { (snapshot) in
//                guard let value = snapshot.value else { return }
//                let teamIds = value as? [Int]
                self.teams.removeAll()
                self.filteredTeams.removeAll()
                if let teamIds = snapshot.value as? [Int] {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addHeader()
        addSearchBar()
        addTeamListTblVw()
        fetchTeamsList()
    }
    
    func _dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissVC(_ sender: UIButton) {
        _dismissVC()
    }
}

//MARK:- Team list management functions
extension FilterTeamsVC {
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

//MARK:- Filter team search bar delegates

extension FilterTeamsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTeams = filterTeams(searchText: searchText)
        teamListTblVw.reloadData()
    }
}


//MARK:- Table view

extension FilterTeamsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filteredTeams[indexPath.row].teamName
        cell.textLabel?.font = UIFont(name: robotoRegular, size: 13)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTeams.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentVCType: VCType = filterVCType == .AllTeams ? .FilterAllTeamsVC : .FilterJudgedTeamsVC
        let teamInfo = filteredTeams[indexPath.row]
        let scoringVC = ScoringVC(previousVCType: currentVCType, teamId: teamInfo.teamId, teamInfo: teamInfo)
        present(scoringVC, animated: true, completion: nil)
    }
}

extension FilterTeamsVC: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        teamSearchBar.endEditing(true)
    }
}
