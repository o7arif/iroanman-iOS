//
//  Access.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/21/21.
//

import Foundation

struct Access : Codable {
    let authType : String?
    let token : String?
    let expiresAt : String?

    enum CodingKeys: String, CodingKey {
        case authType = "auth_type"
        case token = "token"
        case expiresAt = "expires_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        authType = try values.decodeIfPresent(String.self, forKey: .authType)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
    }

}
