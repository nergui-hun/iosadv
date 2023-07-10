//
//  UIColor+Ext.swift
//  Navigation
//
//  Created by M M on 7/6/23.
//

import Foundation
import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
