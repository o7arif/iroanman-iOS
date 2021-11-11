//
//  Access.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/21/21.
//

import Foundation

class Access {
    var authType : String?
    var token : String?
    var expiresAt : String?

    init(fromDictionary dictionary: [String:Any]?) {
        authType = dictionary?["auth_type"] as? String ?? ""
        token = dictionary?["token"] as? String ?? ""
        expiresAt = dictionary?["expires_at"] as? String ?? ""
    }

}
