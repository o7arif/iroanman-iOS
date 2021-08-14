//
//  FakeDataHelper.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import Foundation

class FakeDataHelper {
    
    static func getData(dataSource: DataSource) -> [String] {
        switch dataSource {
        case .gender:
            return getGenders()
        default:
            return []
        }
    }
    
    private static func getGenders() -> [String] {
        var genders: [String] = []
        
        genders.append("Male")
        genders.append("Female")
        genders.append("Others")
        
        return genders
    }
}
