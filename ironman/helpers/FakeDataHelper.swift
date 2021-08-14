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
        case .area:
            return getAreas()
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
    
    private static func getAreas() -> [String] {
        var areas: [String] = []
        
        areas.append("Adabor")
        areas.append("Bashundhara")
        areas.append("Baridhara")
        areas.append("Dhanmondi")
        areas.append("Demra")
        areas.append("Elephant Road")
        areas.append("Hatirpool")
        areas.append("Hatirjheel")
        areas.append("Kalabagan")
        areas.append("Mohammadpur")
        areas.append("Panthapath")
        
        return areas
    }
}
