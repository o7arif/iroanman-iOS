//
//  ServiceData.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/16/21.
//

import Foundation

struct ServiceData : Codable {
    let services : [Service]?

    enum CodingKeys: String, CodingKey {
        case services = "services"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        services = try values.decodeIfPresent([Service].self, forKey: .services)
    }
}
