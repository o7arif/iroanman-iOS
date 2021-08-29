//
//  UIColor.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/12/21.
//

import UIKit

public extension UIColor {
    
    static let primary: UIColor = .color(fromHexString: "00C2CB")
    static let textBlack: UIColor = .color(fromHexString: "001733")
    static let textBlackDark: UIColor = .color(fromHexString: "0E1C43")
    static let textBlackLight: UIColor = .color(fromHexString: "294366")
    static let textGrey: UIColor = .color(fromHexString: "788493")
    static let textRed: UIColor = .color(fromHexString: "FF4141")
    static let segmentColor: UIColor = .color(fromHexString: "1DC1FF")
    
    static func color(fromHexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(colorInteger(fromHexString: fromHexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private static func colorInteger(fromHexString: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: fromHexString)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
