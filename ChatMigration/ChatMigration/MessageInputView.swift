//
//  MessageInputView.swift
//  ChatMigration
//
//  Created by Andra Pop on 14/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

class MessageInputView: UIView {
    
    private var backgroundViewBottomAnchor: NSLayoutConstraint?
    private var topStackViewLayoutSet: NSLayoutConstraintSet?
    private var contentViewLayoutSet: NSLayoutConstraintSet?
    private var windowAnchor: NSLayoutConstraint?
    
    var topStackViewPadding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initUI() {
        autoresizingMask = [.flexibleHeight]
        setupSubviews()
    }
    
    public let separatorLine = SeparatorLine()

    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupSubviews() {
        
//        addSubview(backgroundView)
        addSubview(contentView)
//        addSubview(separatorLine)
  
    }
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
    
    public let topStackView: InputStackView = {
        let stackView = InputStackView(axis: .vertical, spacing: 0)
        stackView.alignment = .fill
        return stackView
    }()
    
    private func activateConstraints() {
        contentViewLayoutSet?.activate()
        topStackViewLayoutSet?.activate()
    }
    
    private func setupConstraints() {
        
        // The constraints within the MessageInputBar
//        separatorLine.addConstraints(topAnchor, left: leftAnchor, right: rightAnchor, heightConstant: separatorLine.height)
//        backgroundViewBottomAnchor = backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        backgroundViewBottomAnchor?.isActive = true
        
        topStackViewLayoutSet = NSLayoutConstraintSet(
            top:    topStackView.topAnchor.constraint(equalTo: topAnchor, constant: topStackViewPadding.top),
            bottom: topStackView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -padding.top),
            left:   topStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: topStackViewPadding.left),
            right:  topStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -topStackViewPadding.right)
        )
        
        contentViewLayoutSet = NSLayoutConstraintSet(
            top:    contentView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: padding.top),
            bottom: contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom),
            left:   contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding.left),
            right:  contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding.right)
        )
        activateConstraints()

    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints(to: window)
    }
    
    private func setupConstraints(to window: UIWindow?) {
        if #available(iOS 11.0, *) {
            guard UIScreen.main.nativeBounds.height == 2436 else { return }
            if let window = window {
                windowAnchor?.isActive = false
                windowAnchor = contentView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: window.safeAreaLayoutGuide.bottomAnchor, multiplier: 1)
                windowAnchor?.constant = -padding.bottom
                windowAnchor?.priority = UILayoutPriority(rawValue: 750)
                windowAnchor?.isActive = true
                backgroundViewBottomAnchor?.constant = 34
            }
        }
    }

}
