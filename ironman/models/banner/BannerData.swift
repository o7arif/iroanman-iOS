//
//  BannerData.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/11/21.
//

import Foundation

struct BannerData : Codable {
    let banners : [Banner]?
    
    enum CodingKeys: String, CodingKey {
        case banners = "banners"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banners = try values.decodeIfPresent([Banner].self, forKey: .banners)
    }
    
}
