//
//  String.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/27/21.
//

import Foundation

extension String {
    
    func toCurrencyFormat() -> String {
        
        if let floatValue = Float(self) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.currencyDecimalSeparator = ","
            return numberFormatter.string(from: NSNumber(value: floatValue)) ?? ""
        }
        return ""
    }
    
}
