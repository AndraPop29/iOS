//
//  SeparatorLine.swift
//  ChatMigration
//
//  Created by Andra Pop on 14/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

class SeparatorLine: UIView {
    
    // MARK: - Properties
    
    /// The height of the line
    var height: CGFloat = 1.0 {
        didSet {
            constraints.filter { $0.identifier == "height" }.forEach { $0.constant = height } // Assumes constraint was given an identifier
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: height)
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Sets up the default properties
    func setup() {
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
