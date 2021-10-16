//
//  Service.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/16/21.
//

import Foundation

struct Service : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let imagePath : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case imagePath = "image_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
    }
}
