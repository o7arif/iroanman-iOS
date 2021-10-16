//
//  VariantResponse.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/17/21.
//

import Foundation

struct VariantResponse : Codable {
    let message : String?
    let variantData : VariantData?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case variantData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        variantData = try values.decodeIfPresent(VariantData.self, forKey: .variantData)
    }

}
