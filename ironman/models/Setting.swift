//
//  Setting.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/25/21.
//

import Foundation

struct Setting : Codable {
    let title : String
    let content : String

    init(fromDictionary dictionary: [String:Any]?) {
        title = dictionary?["title"] as? String ?? ""
        content = dictionary?["content"] as? String ?? ""
    }

}
