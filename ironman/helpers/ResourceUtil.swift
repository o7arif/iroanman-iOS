//
//  ResourceUtil.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/29/21.
//

import UIKit

class ResourceUtil {
    
    public static func numberToStringWithZero(number: Int) -> String {
        if number < 10 {
            return "0\(number)"
        } else {
            return String(number)
        }
    }
    
    public static func makeCurrency(amount: Double, _ hasSymbol: Bool = true) -> String {
        let formattedAmount = String(amount).toCurrencyFormat()
        
        if hasSymbol {
            return "৳\(formattedAmount)"
        } else {
            return formattedAmount
        }
    }
    
    public static func makeUnderlineAndColoredText(string: String, startIndex: Int, length: Int, color: UIColor) -> NSAttributedString {
        let underlineAttributedString = NSMutableAttributedString(string: string)
        underlineAttributedString.addAttribute(.underlineStyle, value: 1, range: NSRange(location: startIndex, length: length))
        underlineAttributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: startIndex, length: length))
        return underlineAttributedString
    }
    
}
