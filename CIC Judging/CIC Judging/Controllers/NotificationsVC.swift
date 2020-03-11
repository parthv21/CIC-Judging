//
//  NotificationsVC.swift
//  CIC Judging
//
//  Created by Parth Tamane on 10/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NotificationVC: UIViewController {
    
    private let headerVw = UIView()
    private let dismissBtn = UIButton()
    private let notificationTblVw = UITableView()
    private var messagesData = [MessageData]()
    
    
    func addHeaderView() {
        makeListHeader(view: view, headerVw: headerVw, title: "Messages", dismissBtn: dismissBtn)
        dismissBtn.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
    }
    
    func addNotificationTableView() {
        self.view.addSubview(notificationTblVw)
        notificationTblVw.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationTblVw.topAnchor.constraint(equalTo: headerVw.bottomAnchor),
            notificationTblVw.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notificationTblVw.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            notificationTblVw.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        notificationTblVw.delegate = self
        notificationTblVw.dataSource = self
        notificationTblVw.estimatedRowHeight = 200
        notificationTblVw.rowHeight = UITableView.automaticDimension
        notificationTblVw.register(MessagesCell.self, forCellReuseIdentifier: messagesCellIdentifier)
        
        fetchMessages()
    }
    
    func fetchMessages() {
        let ref = Database.database().reference()
        ref.child(messagesKey).observe(.value) { (snapshot) in
            do {
                let value = snapshot.value
                let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let decodedTeams =  try JSONDecoder().decode([String: MessageData].self, from: data)
                self.messagesData = decodedTeams.map{ $0.1 }
                self.messagesData.sort { (message1, message2) -> Bool in
                    return parseISODateString(isoDate: message1.timestamp) > parseISODateString(isoDate: message2.timestamp)
                }
                self.notificationTblVw.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addHeaderView()
        addNotificationTableView()
    }
    
    func _dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissVC(_ sender: UIButton) {
        _dismissVC()
    }
}

//MARK:- Notifications table view methods

extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: messagesCellIdentifier) as? MessagesCell {
            cell.configureCell(messageData: messagesData[indexPath.row])
            return cell
        }
        let cell = UITableViewCell()
        cell.textLabel?.text = messagesData[indexPath.row].message
        return cell
    }
}

extension NotificationVC: UITableViewDelegate {
    
}

