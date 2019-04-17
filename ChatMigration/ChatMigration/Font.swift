//
//  Font.swift
//  ChatMigration
//
//  Created by Andra Pop on 11/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

struct Font {
    static func lightFont(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: UIFont.Weight.light)
    }
    
    static func regularFont(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: UIFont.Weight.regular)
        
    }
    
    static func mediumFont(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: UIFont.Weight.medium)
    }
    
    static func semiboldFont(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: UIFont.Weight.semibold)
    }
}

enum FontSize: CGFloat {
    /// 10
    case xSmall = 10
    /// 11
    case small = 11
    /// 12
    case mediumSmall = 12
    /// 14
    case medium = 14
    /// 16
    case mediumLarge = 16
    /// 20
    case large20 = 20
    /// 24
    case large = 24
    /// 30
    case xLarge = 30
}

