//
//  BannerResponse.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/11/21.
//

import Foundation

struct BannerResponse : Codable {
    let message : String?
    let bannerData : BannerData?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case bannerData = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        bannerData = try values.decodeIfPresent(BannerData.self, forKey: .bannerData)
    }
    
}
