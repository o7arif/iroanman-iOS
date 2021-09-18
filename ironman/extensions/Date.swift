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
    
}
