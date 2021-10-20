//
//  LoginData.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/21/21.
//

import Foundation

struct LoginData : Codable {
    let user : User?
    let access : Access?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case access = "access"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        access = try values.decodeIfPresent(Access.self, forKey: .access)
    }

}
