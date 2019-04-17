//
//  Color.swift
//  ChatMigration
//
//  Created by Andra Pop on 11/01/2019.
//  Copyright © 2019 Halcyonmobile. All rights reserved.
//

import UIKit

struct ChatColors {
    static let Gray = UIColor(hexNumber: 0xA4A4A4)
    static let LightBlue = UIColor(hexNumber: 0x6AD9C7)
    static let Blue = UIColor(hexNumber: 0x16ABBF)
    static let DarkBlue = UIColor(hexNumber: 0x107991)
    static let Green = UIColor(hexNumber: 0x6CBD77)
    static let Brown = UIColor(hexNumber: 0xA67D53)
    static let Pink = UIColor(hexNumber: 0xEE74BD)
    static let Purple = UIColor(hexNumber: 0x6E659F)
    static let Red = UIColor(hexNumber: 0xFF4D4E)
    static let Yellow = UIColor(hexNumber: 0xFFA701)
    
    static let Default = Gray
    static let All = [Gray, LightBlue, Blue, DarkBlue, Green, Brown, Pink, Purple, Red, Yellow]
    
    static func stringForColor(color: UIColor) -> String {
        switch color {
        case Gray: return "Gray"
        case LightBlue: return "Light blue"
        case Blue: return "Blue"
        case DarkBlue: return "Dark blue"
        case Green: return "Green"
        case Brown: return "Brown"
        case Pink: return "Pink"
        case Purple: return "Purple"
        case Red: return "Red"
        case Yellow: return "Yellow"
        default: return "Unknown"
        }
    }
}

struct CalendarColors {
    static let actout               = Color.lightRedColor
    static let sober                = Color.lightBlueColor
    static let today                = Color.mediumRedColor
    static let selected             = Color.mediumRedColor
    static let initialSobriety      = Color.darkBlueColor
    static let calendarHeaderBG     = Color.darkBlueColor
    static let weekDayText          = Color.grayColor
    static let buttonBG             = Color.blueColor
    static let dateTextActive       = Color.mediumLightGrayColor
    static let dateTextInActive     = Color.grayColor
}

struct Color {
    
    static let mainBackground                   = UIColor.white
    static let mainBackgroundHighlight          = Color.lightGrayColor
    static let mainBackgroundText               = UIColor.black
    static let mainBackgroundTextInactive       = Color.lightGrayColor
    static let mainBackgroundTextSecondary      = Color.grayColor
    static let mainBackgroundBorder             = Color.grayColor
    static let mainBackgroundCellBorder         = Color.lightGrayColor
    
    static let highlightedLink                  = Color.blueColor
    
    static let primaryAccent                    = Color.darkBlueColor
    static let primaryAccentText                = UIColor.white
    static let primaryAccentTextSecondary       = Color.grayColor
    static let primaryAccentShadow              = Color.darkerBlueColor
    
    static let secondaryAccent                  = Color.blueColor
    static let secondaryAccentHighlight         = Color.lightBlueColor
    static let secondaryAccentText              = UIColor.white
    static let secondaryAccentBorder            = Color.cyanBlueColor
    
    static let defaultBuddyColor                = Color.grayColor
    
    static let reactionHighlight                = Color.extraLightBlueColor
    
    static let error                            = Color.lightRedColor
    
    static let shadow                           = UIColor.black
    static let tertiaryAccentText               = Color.mediumLightGrayColor
    static let tertiaryAccentTextSecondary      = Color.grayColor
    static let tertiaryAccentHighlight          = Color.cyanBlueColor.withAlphaComponent(0.8)
    
    // CR: [MBoti | Low] These four color constants should be moved to the fileprivate raw colors section and not be used within the app directly. [Boti]
    static let clear                            = UIColor.clear
    static let whiteColor                       = UIColor.white
    static let avatarBackground                 = Color.superLightGrayColor
    static let progressEmpty                    = UIColor.darkGray
    static let gray                             = Color.grayColor
    
    static let setBackColor                     = Color.darkCoralColor
    static let victoryColor                     = Color.lightBlueColor
    static let triggeredColor                   = Color.darkYellow
    static let veryLightGray                    = Color.lightestGray
    
    #if DEBUG
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
    #endif
    
    // CR: [MBoti | Low] I would separate these kinds of colors to a different place. They are not stupid-enough, since they have a knowledge/relation to a DTO. Consider moving DTO presentation logic to a whole new class/extension. [TLevi]
    // MARK: - Check-in status colors
    
    static let userCheckInStatusPerformed = UIColor(hexNumber: 0x15abbe)
    static let userCheckInStatusMissed = UIColor(hexNumber: 0xff4d4d)
    
    // MARK: - Avatar colors
    
    static let avatarHexColors = [0xa4a4a4, 0xed74bc, 0x6cbc77, 0x00b0c2, 0x007b94]
    static let defaultAvatarColor = 0xa4a4a4
    
    // MARK: - Private raw colors
    
    fileprivate static let cyanBlueColor = UIColor(hexNumber: 0x68C0B3)
    fileprivate static let lightBlueColor = UIColor(hexNumber: 0x15abbe)
    fileprivate static let blueColor = UIColor(hexNumber: 0x107891)
    fileprivate static let extraLightBlueColor = UIColor(hexNumber: 0xE7F6F8)
    fileprivate static let darkBlueColor = UIColor(hexNumber: 0x15212e)
    fileprivate static let darkerBlueColor = UIColor(hexNumber: 0x213547)
    
    fileprivate static let superLightGrayColor = UIColor(hexNumber: 0xfafafa)
    fileprivate static let lightGrayColor = UIColor(hexNumber: 0xf2f2f2)
    fileprivate static let lightestGray =   UIColor(hexNumber: 0xECECEC)
    fileprivate static let mediumLightGrayColor = UIColor(hexNumber: 0x4c4c4c)
    fileprivate static let grayColor = UIColor(hexNumber: 0x919191)
    
    fileprivate static let lightRedColor = UIColor(hexNumber: 0xff4d4d)
    fileprivate static let mediumRedColor = UIColor(hexNumber: 0xbf3939)
    
    fileprivate static let darkCoralColor = UIColor(hexNumber: 0xff6564)
    fileprivate static let darkYellow = UIColor(hexNumber: 0xffa603)
}

extension UIColor {
    
    // MARK: - Initialization
    
    public convenience init(hexNumber: IntegerLiteralType) {
        let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let blue = CGFloat(hexNumber & 0x0000FF) / 255
        let alpha = CGFloat(1)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hexString: StringLiteralType) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hexString.hasPrefix("0x") {
            let index   = hexString.index(hexString.startIndex, offsetBy: 1)
            let hex     = hexString.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("whatever")
//                    printError("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
//                printError("Scan hex error")
            }
        } else {
//            printError("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    // MARK: - Utilities
    
    public func hexColor() -> Int {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            
            let rgb = (iRed << 16) + (iGreen << 8) + iBlue
            return rgb
        }
        
        return 0
    }
}


