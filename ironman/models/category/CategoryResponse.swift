//
//  CategoryResponse.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/11/21.
//

import Foundation

struct CategoryResponse : Codable {
    let message : String?
    let categoryData : CategoryData?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case categoryData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        categoryData = try values.decodeIfPresent(CategoryData.self, forKey: .categoryData)
    }

}
