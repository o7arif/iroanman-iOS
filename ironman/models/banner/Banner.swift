//
//  Banner.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/11/21.
//

import Foundation

struct Banner : Codable {
    let title : String?
    let description : String?
    let imagePath : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imagePath = "image_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
    }

}
