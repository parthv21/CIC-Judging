//
//  NotesCell.swift
//  CIC Judging
//
//  Created by Parth Tamane on 04/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit

class NotesCell: UITableViewCell {
    internal let notesTxtArea = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let container = UIView()
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.black.cgColor
        //Title
        let titleLbl = UILabel()
        container.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            titleLbl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            titleLbl.widthAnchor.constraint(equalToConstant: 150),
            titleLbl.heightAnchor.constraint(equalToConstant: 30)
        ])
        titleLbl.font = contentFontBold
        titleLbl.textColor = .black
        titleLbl.text = "Other Notes"
        //Text View
        container.addSubview(notesTxtArea)
        notesTxtArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesTxtArea.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            notesTxtArea.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            notesTxtArea.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            notesTxtArea.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            notesTxtArea.heightAnchor.constraint(equalToConstant: 150)
        ])
        notesTxtArea.layer.borderColor = UIColor.black.cgColor
        notesTxtArea.layer.borderWidth = 1
        notesTxtArea.font = contentFontRegular
        notesTxtArea.textColor = .black
        notesTxtArea.delegate = self
        
        let cellTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        container.addGestureRecognizer(cellTap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        notesTxtArea.endEditing(true)
    }
    
    func configureCell(noteText: String) {
        self.notesTxtArea.text = noteText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- Text view changes

extension NotesCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let notificationName = NSNotification.Name(rawValue: scoreUpdateNotificationKey)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [ScoringCriterion.Notes.rawValue: textView.text ?? ""])
    }
}

