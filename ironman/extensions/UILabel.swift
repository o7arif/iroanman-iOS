//
//  UILabel.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/25/21.
//

import Foundation
import UIKit

extension UILabel {
    
    func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
}
