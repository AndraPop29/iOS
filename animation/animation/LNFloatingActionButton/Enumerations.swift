//
//  Enumerations.swift
//  LNFloatingActionButton
//
//  Created by Shuhei Kawaguchi on 2016/12/05.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import Foundation
import UIKit

public enum TitleTextAlignment {
    case left
    case center
    case right
}

public enum TitleLabelPosition {
    case left
    case right
}

public enum CellHorizontalAlign {
    case left
    case center
    case right
    
}

public enum LevelProgress: Int {
    case empty = 0
    case low = 20
    case mediumLow = 40
    case medium = 60
    case mediumHigh = 80
    case high = 100
    case full = 120
    
    var image: UIImage {
        switch self {
        case .empty:        return UIImage(named: "badge_level0")!
        case .low:          return UIImage(named: "badge_level1")!
        case .mediumLow:    return UIImage(named: "badge_level2")!
        case .medium:       return UIImage(named: "badge_level3")!
        case .mediumHigh:   return UIImage(named: "badge_level4")!
        case .high:         return UIImage(named: "badge_level5")!
        case .full:         return UIImage(named: "badge_level6")!
        }
    }
}
