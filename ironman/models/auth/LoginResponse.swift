//
//  LoginResponse.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/21/21.
//

import Foundation

struct LoginResponse : Codable {
    let message : String?
    let loginData : LoginData?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case loginData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        loginData = try values.decodeIfPresent(LoginData.self, forKey: .loginData)
    }

}
