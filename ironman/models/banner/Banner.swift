//
//  Banner.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/11/21.
//

import Foundation

struct Banner : Codable {
    let title : String
    let description : String
    let imagePath : String

    init(fromDictionary dictionary: [String:Any]?) {
        title = dictionary?["title"] as? String ?? ""
        description = dictionary?["description"] as? String ?? ""
        imagePath = dictionary?["image_path"] as? String ?? ""
    }

}
