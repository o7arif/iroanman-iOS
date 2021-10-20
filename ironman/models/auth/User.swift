//
//  User.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/21/21.
//

import Foundation

struct User : Codable {
    let id : Int?
    let name : String?
    let email : String?
    let mobile : String?
    let profilePhoto : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case profilePhoto = "profile_photo_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        profilePhoto = try values.decodeIfPresent(String.self, forKey: .profilePhoto)
    }

}
