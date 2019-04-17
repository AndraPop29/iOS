//
//  MessageComposeTextView.swift
//  ChatMigration
//
//  Created by Andra Pop on 14/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

class MessageComposeTextView : UITextField {
    
    init() {
        super.init(frame: CGRect.zero)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    fileprivate func initUI() {
        
//        font = Font.lightFont(size: .mediumLarge)
//        textColor = Color.primaryAccentText
//        backgroundColor = Color.primaryAccentText.withAlphaComponent(0.1)
//        textAlignment = NSTextAlignment.center
//        layer.cornerRadius = 5
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 5)
    }
}
