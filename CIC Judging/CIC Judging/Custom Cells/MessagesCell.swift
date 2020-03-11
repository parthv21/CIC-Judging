//
//  MessagesCell.swift
//  CIC Judging
//
//  Created by Parth Tamane on 10/03/20.
//  Copyright © 2020 Parth Tamane. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift

class MessagesCell: UITableViewCell {
    
    private let priorityLbl = UILabel()
    private let messageLbl = UILabel()
    private let timeStampLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
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
        //Alert Label
        priorityLbl.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        priorityLbl.text = String.fontAwesomeIcon(name: .ghost)
        container.addSubview(priorityLbl)
        priorityLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            priorityLbl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            priorityLbl.heightAnchor.constraint(equalToConstant: 30),
            priorityLbl.widthAnchor.constraint(equalToConstant: 30)
        ])
        //Message Label
        container.addSubview(messageLbl)
        messageLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLbl.leadingAnchor.constraint(equalTo: priorityLbl.trailingAnchor, constant: 10),
            messageLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            messageLbl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
        ])
        messageLbl.font = contentFontRegular
        messageLbl.textColor = .black
        messageLbl.lineBreakMode = .byWordWrapping
        messageLbl.numberOfLines = 0
        //Time Stamp Label
        container.addSubview(timeStampLbl)
        timeStampLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeStampLbl.leadingAnchor.constraint(equalTo: priorityLbl.trailingAnchor, constant: 10),
            timeStampLbl.topAnchor.constraint(equalTo: messageLbl.bottomAnchor, constant: 10),
            timeStampLbl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            timeStampLbl.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            timeStampLbl.heightAnchor.constraint(equalToConstant: 30)
        ])
        timeStampLbl.textColor = .black
        timeStampLbl.font = UIFont(name: robotoRegular, size: 15)
    }
    
    func configureCell(messageData: MessageData) {
        messageLbl.text = messageData.message
        timeStampLbl.text = timestampToString(isoDate: messageData.timestamp)

        switch messageData.priority {
        case MessagePrioirty.Low.rawValue:
            priorityLbl.text = String.fontAwesomeIcon(name: .infoCircle)
            priorityLbl.textColor = lowPriorityBlue
        case MessagePrioirty.Medium.rawValue:
            priorityLbl.text = String.fontAwesomeIcon(name: .exclamationCircle)
            priorityLbl.textColor = mediumPriorityOrange
        case MessagePrioirty.High.rawValue:
            priorityLbl.text = String.fontAwesomeIcon(name: .exclamationTriangle)
            priorityLbl.textColor = highPriorityRed
        default:
            priorityLbl.text = String.fontAwesomeIcon(name: .infoCircle)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
