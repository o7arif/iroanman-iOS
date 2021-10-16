//
//  ServiceResponse.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/16/21.
//

import Foundation

struct ServiceResponse : Codable {
    let message : String?
    let serviceData : ServiceData?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case serviceData = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        serviceData = try values.decodeIfPresent(ServiceData.self, forKey: .serviceData)
    }
}
