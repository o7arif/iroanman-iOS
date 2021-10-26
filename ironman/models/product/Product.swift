//
//  Product.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/17/21.
//

import Foundation

struct Product : Codable {
    let id : Int?
    let name : String?
    let slug : String?
    let currentPrice : Double?
    let oldPrice : Double?
    let imagePath : String?
    let discountPercentage : Int?
    let service : Service?
    let variant : Variant?
    var count: Int = 0

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case currentPrice = "current_price"
        case oldPrice = "old_price"
        case imagePath = "image_path"
        case discountPercentage = "discount_percentage"
        case service = "service"
        case variant = "variant"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        currentPrice = try values.decodeIfPresent(Double.self, forKey: .currentPrice)
        oldPrice = try values.decodeIfPresent(Double.self, forKey: .oldPrice)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        discountPercentage = try values.decodeIfPresent(Int.self, forKey: .discountPercentage)
        service = try values.decodeIfPresent(Service.self, forKey: .service)
        variant = try values.decodeIfPresent(Variant.self, forKey: .variant)
        count = try values.decodeIfPresent(Int.self, forKey: .count) ?? 0
    }

}
