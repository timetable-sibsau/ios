//
//  Colors.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

public class Colors {
    
    static var shadowColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.white
                } else {
                    /// Return the color for Light Mode
                    return UIColor.black
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor.black
        }
    }
    
    static var backgroungColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    // было 15
                    return UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)
                } else {
                    /// Return the color for Light Mode
                    // было 240
                    return UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        }
    }
    
    static var sibsuBlue: UIColor {
        return UIColor(red: 75.0/255.0, green: 123.0/255.0, blue: 184.0/255.0, alpha: 1.0)
    }
    
    static var sibsuGreen: UIColor {
        return UIColor(red: 138.0/255.0, green: 189.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    }
    
    static var white: UIColor {
        if #available(iOS 13, *) {
            return UIColor.systemBackground
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor.white
        }
    }
    
    static var black: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    // было 15
                    return UIColor.white
                } else {
                    /// Return the color for Light Mode
                    // было 240
                    return UIColor.black
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor.black
        }
    }
    
}
