//
//  VariantData.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/17/21.
//

import Foundation

struct VariantData : Codable {
    let variants : [Variant]?

    enum CodingKeys: String, CodingKey {
        case variants = "variants"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        variants = try values.decodeIfPresent([Variant].self, forKey: .variants)
    }

}
