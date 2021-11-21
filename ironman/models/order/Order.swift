//
//  Order.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/14/21.
//

import Foundation

struct Order {
    let id : Int
    let orderCode : String
    let customer : Customer
    let discount : String
    let amount : Double
    let orderStatus : String
    let paymentStatus : String
    let pickAt : String
    let deliveryAt : String
    let orderAt : String
    let rating : String
    let address : Address

    init(fromDictionary dictionary: [String:Any]?) {
        id = dictionary?["id"] as? Int ?? 0
        orderCode = dictionary?["order_code"] as? String ?? ""
        
        if let customerData = dictionary?["customer"] as? [String : Any] {
            customer = Customer(fromDictionary: customerData)
        } else {
            customer = Customer()
        }
        
        discount = dictionary?["discount"] as? String ?? ""
        amount = dictionary?["amount"] as? Double ?? 0
        orderStatus = dictionary?["order_status"] as? String ?? ""
        paymentStatus = dictionary?["payment_status"] as? String ?? ""
        pickAt =  dictionary?["pick_at"] as? String ?? ""
        deliveryAt = dictionary?["delivery_at"] as? String ?? ""
        orderAt = dictionary?["order_at"] as? String ?? ""
        rating = dictionary?["rating"] as? String ?? ""
        
        if let serviceData = dictionary?["address"] as? [String : Any] {
            address = Address(fromDictionary: serviceData)
        } else {
            address = Address()
        }
    }

}
