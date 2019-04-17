//
//  ViewController.swift
//  ChatMigration
//
//  Created by Andra Pop on 11/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

let kWidthScreen = UIScreen.main.bounds.width
let kRectNavigationTitleView: CGRect = CGRect(x: 0, y: 0, width: kWidthScreen - 120, height: 40)

class ChatViewController: UIViewController {
    
    fileprivate var titleView: ConversationTitleView!
    fileprivate var settingsButton: UIBarButtonItem?
    private var messageInputView: MessageInputView


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initView()
    }
    
    override var inputAccessoryView: UIView? {
        return messageInputView
    }
    
    init() {
        self.messageInputView = MessageInputView()
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initView() {
        titleView = ConversationTitleView()
        titleView.frame = kRectNavigationTitleView
        navigationItem.titleView = titleView
        navigationItem.leftBarButtonItem = UIBarButtonItem(type: .back, target: self, action: #selector(backButtonTap), contentAlignment: .left)
        
        settingsButton = UIBarButtonItem(type: .settings, target: self, action: #selector(conversationSettingsTapped), contentAlignment: UIControl.ContentHorizontalAlignment.right)
        navigationItem.rightBarButtonItems = [settingsButton!]
        settingsButton?.isEnabled = true
        
    }
    
    @objc fileprivate func backButtonTap() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func conversationSettingsTapped() {
        return
    }
    
}

extension UIBarButtonItem {
    
    convenience init(type: NavBarButtonType, target: AnyObject?, action: Selector, contentAlignment: UIControl.ContentHorizontalAlignment) {
        switch type {
            
        case .back, .settings:
            let button = UIButton(type: UIButton.ButtonType.custom)
            button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 40))
            button.setImage(type.image, for: .normal)
            button.contentHorizontalAlignment = contentAlignment
            button.addTarget(target, action: action, for: .touchUpInside)
            self.init(customView: button)
            
            break
        }
    }
}

enum NavBarButtonType {
    case settings, back
    
    var image: UIImage? {
        switch self {
        case .settings:
            return #imageLiteral(resourceName: "icon_settings")
        case .back:
            return #imageLiteral(resourceName: "icon_back")
        }
    }
}


