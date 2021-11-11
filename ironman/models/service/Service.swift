//
//  Service.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/16/21.
//

import Foundation

struct Service : Codable {
    let id : Int
    let name : String
    let description : String
    let imagePath : String
    
    init() {
        id = 0
        name = ""
        description = ""
        imagePath = ""
    }
    
    init(fromDictionary dictionary: [String:Any]?) {
        id = dictionary?["id"] as? Int ?? 0
        name = dictionary?["name"] as? String ?? ""
        description = dictionary?["description"] as? String ?? ""
        imagePath = dictionary?["image_path"] as? String ?? ""
    }
    
}
