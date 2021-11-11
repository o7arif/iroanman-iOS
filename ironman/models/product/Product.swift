//
//  Product.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/17/21.
//

import Foundation

struct Product : Codable {
    let id : Int
    let name : String
    let slug : String
    let currentPrice : Double
    let oldPrice : Double
    let imagePath : String
    let discountPercentage : Int
    let service : Service
    let variant : Variant
    var count: Int = 0

    init(fromDictionary dictionary: [String:Any]?) {
        id = dictionary?["id"] as? Int ?? 0
        name = dictionary?["name"] as? String ?? ""
        slug = dictionary?["slug"] as? String ?? ""
        currentPrice = dictionary?["current_price"] as? Double ?? 0
        oldPrice = dictionary?["old_price"] as? Double ?? 0
        imagePath = dictionary?["image_path"] as? String ?? ""
        discountPercentage =  dictionary?["discount_percentage"] as? Int ?? 0
        
        if let serviceData = dictionary?["service"] as? [String : Any] {
            service = Service(fromDictionary: serviceData)
        } else {
            service = Service()
        }
        
        if let variantData = dictionary?["variant"] as? [String : Any] {
            variant = Variant(fromDictionary: variantData)
        } else {
            variant = Variant()
        }
        
        count = dictionary?["count"] as? Int ?? 0
    }

}
