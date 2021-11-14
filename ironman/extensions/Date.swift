//
//  Date.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 9/18/21.
//

import Foundation

extension Date {
    
    public func stringShort() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    public func serverDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        let string: String = formatter.string(from: self)
        return string
    }
    
}
