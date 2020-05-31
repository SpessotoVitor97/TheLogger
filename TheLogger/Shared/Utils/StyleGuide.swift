//
//  StyleGuide.swift
//  Logger
//
//  Created by Vitor Spessoto on 5/12/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import UIKit

struct StyleGuide {
    
    //*************************************************
    // MARK: - Public structs
    //*************************************************
    struct ViewStyle {
        struct View {
            static var backgroundColor: UIColor {
                return .white
            }
            
            static var secondBackgroudColor: UIColor {
                return StyleGuide.Color.gray
            }
        }
        
        struct NaviagationBar {
            static var backgroundColor: UIColor {
                return StyleGuide.Color.secondaryGray
            }
            
            static var titleFont: UIFont {
                return FontStyle.semibold(size: 16)
            }
            
            static var titleColor: UIColor {
                return StyleGuide.Color.blue
            }
            
            static var tintColor: UIColor {
                return StyleGuide.Color.blue
            }
        }
        
        struct Components {
            static var backgroundColor: UIColor {
                return StyleGuide.Color.blue
            }
        }
    }
}

//*************************************************
// MARK: - Enums
//*************************************************
extension StyleGuide {
    
    enum TextStyle {
        case bigTitle
        case bigText
        case title
        case text
        case smallTitle
        case smallText
        case legend
        case legendTitle
        case link
        case smallLink
        case error
        case smallError
        
        var font: UIFont {
            switch self {
                case .bigTitle:
                    return FontStyle.semibold(size: 20)
                case .bigText:
                    return FontStyle.light(size: 20)
                case .title:
                    return FontStyle.semibold(size: 16)
                case .text:
                    return FontStyle.light(size: 16)
                case .smallTitle:
                    return FontStyle.regular(size: 14)
                case .smallText:
                    return FontStyle.light(size: 14)
                case .legend:
                    return FontStyle.light(size: 12)
                case .legendTitle:
                    return FontStyle.regular(size: 12)
                case .link:
                    return FontStyle.regular(size: 16)
                case .smallLink:
                    return FontStyle.regular(size: 14)
                case .error:
                    return FontStyle.regular(size: 14)
                case .smallError:
                    return FontStyle.regular(size: 12)
            }
        }
    }
    
    enum TextColor {
        case primary
        case secondary
        case tertiary
        case green
        case blue
        case red
        case black
        case white
        
        var color: UIColor {
            switch self {
            case .primary:
                return UIColor(hexadecimal: 0x303030)
            case .secondary:
                return UIColor(hexadecimal: 0x707070)
            case .tertiary:
                return UIColor(hexadecimal: 0xAAAAAA)
            case .green:
                return StyleGuide.Color.green
            case .blue:
                return StyleGuide.Color.blue
            case .red:
                return StyleGuide.Color.red
            case .black:
                return .black
            case .white:
                return .white
            }
        }
    }
}

//*************************************************
// MARK: - Private structs
//*************************************************
extension StyleGuide {
    
    private struct Color {
        static var blue = UIColor(hexadecimal: 0x2A6CB4)
        static var secondaryBlue = UIColor(hexadecimal: 0x5F90C6)
        static var tertiaryBlue = UIColor(hexadecimal: 0xC8D9EB)
        static var green = UIColor(hexadecimal: 0x02B302)
        static var secondaryGreen = UIColor(hexadecimal: 0x41C641)
        static var tertiaryGreen = UIColor(hexadecimal: 0xBFECBF)
        static var red = UIColor(hexadecimal: 0xE4393C)
        static var secondaryRed = UIColor(hexadecimal: 0xEB6A6D)
        static var tertiaryRed = UIColor(hexadecimal: 0xF8CDCE)
        static var gray = UIColor(hexadecimal: 0xEFEFEF)
        static var secondaryGray = UIColor(hexadecimal: 0xFAFAFA)
        static var tertiaryGray = UIColor(hexadecimal: 0xCCCCCC)
    }
    
    private struct Padding {
        static var top: CGFloat = 8
        static var bottom: CGFloat = 8
        static var trailing: CGFloat = 8
        static var leading: CGFloat = 8
        static var margins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private struct FontStyle {
        static func light(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
        
        static func regular(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func semibold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
    }
}

extension UILabel {
    func configure(style: StyleGuide.TextStyle, color: StyleGuide.TextColor = .primary) {
        self.font = style.font
        self.textColor = color.color
    }
}

extension UITextField {
    func configure(style: StyleGuide.TextStyle, color: StyleGuide.TextColor = .primary) {
        self.font = style.font
        self.textColor = color.color
    }
}

extension UIButton {
    func configure(style: StyleGuide.TextStyle, color: StyleGuide.TextColor = .primary) {
        self.titleLabel?.font = style.font
        self.setTitleColor(color.color, for: .normal)
    }
}

extension NSAttributedString {
    static func attributes(style: StyleGuide.TextStyle, color: StyleGuide.TextColor = .primary, isStrikethrough: Bool = false, isUnderline: Bool = false) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.font] = style.font
        attributes[NSAttributedString.Key.foregroundColor] = color.color
        
        if isStrikethrough {
            attributes[NSAttributedString.Key.strikethroughStyle] = NSUnderlineStyle.single.rawValue
            attributes[NSAttributedString.Key.strikethroughColor] = color.color
        }
        
        if isUnderline {
            attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
            attributes[NSAttributedString.Key.underlineColor] = color.color
        }
        
        return attributes
    }
}
