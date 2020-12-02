//
//  ChatScreenCell.swift
//  ChatScreen
//
//  Created by Hakan Silek on 28.11.2020.
//

import UIKit

class ChatViewCell: UITableViewCell {
    private let messageViewLeadingAndTrailingConstraintConstant: CGFloat = 12
    private let messageViewTopConstraintConstant: CGFloat = 12
    private let messageViewBottomConstraintConstant: CGFloat = 8
    private let messageViewWidthMultiplier: CGFloat = 0.7
    private let messageViewWidth: CGFloat = 250
    private let messageLabelConstans: CGFloat = 8
    
    private let messageView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var messageViewLeadingAnchor: NSLayoutConstraint?
    
    var messageViewTrailingAnchor: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        addSubview(messageView)
        messageView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: topAnchor, constant: messageViewTopConstraintConstant),
            messageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -messageViewBottomConstraintConstant),
            messageView.widthAnchor.constraint(lessThanOrEqualToConstant: messageViewWidth),
            
            messageLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: messageLabelConstans),
            messageLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -messageLabelConstans),
            messageLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: messageLabelConstans),
            messageLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor,constant: -messageLabelConstans)
        ])
        messageViewLeadingAnchor = messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: messageViewLeadingAndTrailingConstraintConstant)
        
        messageViewTrailingAnchor = messageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -messageViewLeadingAndTrailingConstraintConstant)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ChatViewCell{
    func configureCell(messageRow: MessageRow?) {
        messageViewLeadingAnchor?.isActive = false
        messageViewTrailingAnchor?.isActive = false
        if let message = messageRow{
            messageLabel.text = message.message
            
            if message.isIncoming {
                messageView.backgroundColor = .lightGray
                messageViewLeadingAnchor?.isActive = true
                messageViewTrailingAnchor?.isActive = false
            }else{
                messageView.backgroundColor = .systemGreen
                messageViewLeadingAnchor?.isActive = false
                messageViewTrailingAnchor?.isActive = true
            }
        }
    }
}
