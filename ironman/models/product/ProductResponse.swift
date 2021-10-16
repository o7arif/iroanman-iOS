//
//  ProductResponse.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/17/21.
//

import Foundation

struct ProductResponse : Codable {
    let message : String?
    let productData : ProductData?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case productData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        productData = try values.decodeIfPresent(ProductData.self, forKey: .productData)
    }

}
