//
//  ViewController.swift
//  ChatScreen
//
//  Created by Hakan Silek on 27.11.2020.
//

import UIKit

class ChatViewController: UITableViewController {
    private let cellID = "cellID"
    
    private let messages = [
        [
            MessageRow(message: "Hello Hakan!", isIncoming: true, messageDate: Date.dateFromString(stringDate: "09/11/2020")),
            MessageRow(message: "Fusce in lorem sit amet mauris dictum faucibus eget vitae orci. Nulla quis consectetur nisi. Pellentesque ac purus cursus, porttitor risus sit amet, bibendum turpis.", isIncoming: false, messageDate: Date.dateFromString(stringDate: "09/11/2020")),
        ],
        [
            MessageRow(message: "Nullam sed dictum metus.", isIncoming: true, messageDate: Date.dateFromString(stringDate: "11/11/2020")),
            MessageRow(message: "Morbi feugiat, sem nec efficitur bibendum, ex risus ornare erat, ac ultrices tortor nisl non ex.", isIncoming: true, messageDate: Date.dateFromString(stringDate: "11/11/2020")),
            MessageRow(message: "Nunc eleifend efficitur volutpat. In maximus, diam ut luctus fringilla, tellus mi aliquet mauris, eu fringilla justo tellus ut enim. Cras pellentesque pulvinar purus, ultrices volutpat diam elementum sed.", isIncoming: false, messageDate: Date.dateFromString(stringDate: "11/11/2020")),
            MessageRow(message: "Cras ultricies finibus lectus scelerisque faucibus. ", isIncoming: true, messageDate: Date.dateFromString(stringDate: "11/11/2020"))
        ],
        [
            MessageRow(message: "Sed in ipsum et mauris lobortis efficitur.", isIncoming: true, messageDate: Date.dateFromString(stringDate: "12/11/2020")),
            MessageRow(message: "Integer id aliquet ipsum, nec eleifend nisi. Aliquam pulvinar quis tellus mollis fermentum. Mauris facilisis nunc a mauris gravida hendrerit. Sed placerat neque libero, ut accumsan velit dictum ac. Cras sapien metus, porttitor id venenatis sit amet, bibendum a metus. ", isIncoming: false, messageDate: Date.dateFromString(stringDate: "12/11/2020")),
        ]
    ]
    
    private let chatTextField: CustomTextField = {
        let tv = CustomTextField()
        tv.backgroundColor = .systemGray5
        tv.layer.cornerRadius = 5
        tv.placeholder = "Message"
        tv.layer.masksToBounds = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let chatSendMessageButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        btn.tintColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationView()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: self.messages.count-1), at: .top, animated: true)
    }
    
    lazy var customInputAccessoryView:UIView={
        let chatInputView = CustomInputView()
        chatInputView.autoresizingMask = .flexibleHeight
        chatInputView.backgroundColor = .systemGray4
        chatInputView.addSubview(chatTextField)
        chatInputView.addSubview(chatSendMessageButton)
        
        let topAnchorAndBottomAndTrailingAnchor: CGFloat = 5
        let imageWidthHeightAnchor: CGFloat = 30
        let chatInputViewLayoutMarginsGuide = chatInputView.layoutMarginsGuide
        
        NSLayoutConstraint.activate(
            [
                chatTextField.leadingAnchor.constraint(equalTo: chatInputViewLayoutMarginsGuide.leadingAnchor),
                chatTextField.topAnchor.constraint(equalTo: chatInputViewLayoutMarginsGuide.topAnchor, constant: topAnchorAndBottomAndTrailingAnchor),
                chatTextField.bottomAnchor.constraint(equalTo: chatInputViewLayoutMarginsGuide.bottomAnchor, constant: -topAnchorAndBottomAndTrailingAnchor),
                chatTextField.trailingAnchor.constraint(equalTo: chatSendMessageButton.leadingAnchor, constant: -topAnchorAndBottomAndTrailingAnchor),
                
                chatSendMessageButton.trailingAnchor.constraint(equalTo: chatInputViewLayoutMarginsGuide.trailingAnchor),
                chatSendMessageButton.topAnchor.constraint(equalTo: chatInputViewLayoutMarginsGuide.topAnchor,constant: topAnchorAndBottomAndTrailingAnchor),
                chatSendMessageButton.widthAnchor.constraint(equalToConstant: imageWidthHeightAnchor),
                chatSendMessageButton.heightAnchor.constraint(equalToConstant: imageWidthHeightAnchor),
                chatSendMessageButton.bottomAnchor.constraint(equalTo: chatInputViewLayoutMarginsGuide.bottomAnchor, constant: -topAnchorAndBottomAndTrailingAnchor)
            ]
        )
        
        return chatInputView
    }()
    
    override var inputAccessoryView: UIView?{
        get{
            return customInputAccessoryView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
}

extension ChatViewController{
    
    private func setupView(){
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        tableView.register(ChatViewCell.self, forCellReuseIdentifier: cellID)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        view.backgroundColor = .systemGray6
    }
}

extension ChatViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatViewCell
        
        cell.configureCell(messageRow: messages[indexPath.section][indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        lbl.textColor = .systemGray3
        lbl.layer.cornerRadius = 10
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.layer.masksToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        if let firstMessageOfSection = messages[section].first{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Date.humanFormat
            lbl.text = dateFormatter.string(from: firstMessageOfSection.messageDate)
            headerView.addSubview(lbl)
            NSLayoutConstraint.activate(
                [
                    lbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                    lbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                    lbl.widthAnchor.constraint(equalTo: headerView.widthAnchor,multiplier: 0.25),
                    lbl.heightAnchor.constraint(equalTo: headerView.heightAnchor,multiplier: 0.8)
                ]
            )
            
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension ChatViewController{
    private func customNavigationView(){
        let imageSize: CGFloat = 30
        
        let imageView : UIImageView = {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "steve"))
            imageView.layer.cornerRadius = imageSize/2
            imageView.layer.masksToBounds = true
            return imageView
        }()
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
        ])
        
        let title : UILabel = {
            let title = UILabel()
            title.font = UIFont.boldSystemFont(ofSize: 12)
            title.text = "Steve"
            return title
        }()
        
        let vStack = UIStackView(arrangedSubviews: [imageView, title])
        vStack.alignment = .center
        vStack.axis = .vertical
        
        navigationItem.titleView = vStack
    }
}

