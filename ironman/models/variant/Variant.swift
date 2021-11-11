//
//  Variant.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/17/21.
//

import Foundation

struct Variant : Codable {
    let id : Int
    let name : String
    
    init() {
        id = 0
        name = ""
    }

    init(fromDictionary dictionary: [String:Any]?) {
        id = dictionary?["id"] as? Int ?? 0
        name = dictionary?["name"] as? String ?? ""
    }

}
