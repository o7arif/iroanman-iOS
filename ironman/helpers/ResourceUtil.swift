//
//  ResourceUtil.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/29/21.
//

import Foundation

class ResourceUtil {
    
    public static func numberToStringWithZero(number: Int) -> String {
        if number < 10 {
            return "0\(number)"
        } else {
            return String(number)
        }
    }
}
