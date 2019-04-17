//
//  ConversationTitleView.swift
//  ChatMigration
//
//  Created by Andra Pop on 11/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

class ConversationTitleView: UIView {
    
    fileprivate(set) var colorIcon: UIImageView!
    fileprivate(set) var titleLabel: UILabel!
    fileprivate(set) var subtitleLabel: UILabel!
    
    // MARK: - Lifecyle
    
    init() {
        super.init(frame: CGRect.zero)
        initView()
        updateWithConversation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    fileprivate func initView() {
        let titleContainer = UIView().autoLayoutView()
        addSubview(titleContainer)
        
        colorIcon = UIImageView().autoLayoutView()
        colorIcon.contentMode = UIView.ContentMode.center
        titleContainer.addSubview(colorIcon)
        
        titleLabel = UILabel().autoLayoutView()
        titleLabel.font = Font.mediumFont(size: .mediumLarge)
        titleLabel.textColor = .black
        titleLabel.textAlignment = NSTextAlignment.center
        titleContainer.addSubview(titleLabel)
        
        subtitleLabel = UILabel().autoLayoutView()
        subtitleLabel.clipsToBounds = true
        subtitleLabel.font = Font.lightFont(size: .small)
        subtitleLabel.textColor = .black
        subtitleLabel.textAlignment = NSTextAlignment.center
        subtitleLabel.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        addSubview(subtitleLabel)
        
        let views: [String : UIView] = ["titleView": titleContainer, "icon": colorIcon, "title" : titleLabel, "subtitle" : subtitleLabel]
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[icon]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[icon]-[title]-|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleView][subtitle]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[subtitle]|", options: [], metrics: nil, views: views)
        
        constraints.append(titleContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Utilities
    
    func updateWithConversation() {
        colorIcon.image = UIImage(named: "icon_passcode_full")?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = "Andra"
        subtitleLabel.text = "Ionut, Andra, Mara"
        colorIcon.tintColor = .blue
        layoutIfNeeded()
    }
}

extension UIView {
    
    public func autoLayoutView() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}


