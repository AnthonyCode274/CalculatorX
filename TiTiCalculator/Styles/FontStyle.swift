//
//  FontStyle.swift
//  ThietThachClient
//
//  Created by Phuong Duong on 11/25/21.
//

import Foundation
import SwiftUI

extension Font {
    // Font name
    enum FontType : String {
        case RobotoRegular = "Roboto-Regular"
        case RobotoBold = "Roboto-Bold"
        case RobotoBoldItalic = "Roboto-BoldItalic"
        case RobotoMedium = "Roboto-Medium"
        case RobotoMediumItalic = "Roboto-MediumItalic"
        case RobotoItalic = "Roboto-Italic"
        case RobotoLight = "Roboto-Light"
        case RobotoLightItalic = "Roboto-LightItalic"
        case RobotoBlack = "Roboto-Black"
        case RobotoBlackItalic = "Roboto-BlackItalic"
        case RobotoThin = "Roboto-Thin"
        case RobotoThinItalic = "Roboto-ThinItalic"
    }
    
    /// Regular
    public static func regular(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoRegular.rawValue, size: size)
    }
    /// Light
    public static func light(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoLight.rawValue, size: size)
    }
    /// Light Italic
    public static func lightItalic(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoLightItalic.rawValue, size: size)
    }
    /// Medium
    public static func medium(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoMedium.rawValue, size: size)
    }
    /// Medium Italic
    public static func mediumItalic(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoMediumItalic.rawValue, size: size)
    }
    /// Bold
    public static func bold(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoBold.rawValue, size: size)
    }
    /// BoldItalic
    public static func boldItalic(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoBoldItalic.rawValue, size: size)
    }
    /// Thin
    public static func thin(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoThin.rawValue, size: size)
    }
    /// Thin Italic
    public static func thinItalic(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoThinItalic.rawValue, size: size)
    }
    /// Italic
    public static func italic(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoItalic.rawValue, size: size)
    }
    /// Black
    public static func black(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoBlack.rawValue, size: size)
    }
    /// Black Italic
    public static func blackItalic(size: CGFloat) -> Font {
        return Font.custom(Font.FontType.RobotoBlackItalic.rawValue, size: size)
    }
    
}
