//
//  Address.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import Foundation

struct Address : Codable {
    let id : Int
    let addressName : String
    let roadNo : String
    let houseNo : String
    let flatNo : String
    let block : String
    let area : String
    let subDistrictId : Int
    let districtId : Int
    var addressLine: String
    var postCode: String
    var latitude: Double
    var longitude: Double
    
    init() {
        id = 0
        addressName = ""
        roadNo = ""
        houseNo = ""
        flatNo = ""
        block = ""
        area =  ""
        subDistrictId = 0
        districtId = 0
        addressLine = ""
        postCode = ""
        latitude = 0
        longitude = 0
    }

    init(fromDictionary dictionary: [String:Any]?) {
        id = dictionary?["id"] as? Int ?? 0
        addressName = dictionary?["address_name"] as? String ?? ""
        roadNo = dictionary?["road_no"] as? String ?? ""
        houseNo = dictionary?["house_no"] as? String ?? ""
        flatNo = dictionary?["flat_no"] as? String ?? ""
        block = dictionary?["block"] as? String ?? ""
        area = dictionary?["area"] as? String ?? ""
        subDistrictId = dictionary?["sub_district_id"] as? Int ?? 0
        districtId = dictionary?["district_id"] as? Int ?? 0
        addressLine = dictionary?["address_line"] as? String ?? ""
        postCode = dictionary?["post_code"] as? String ?? ""
        latitude = dictionary?["latitude"] as? Double ?? 0
        longitude = dictionary?["longitude"] as? Double ?? 0
    }
    
    
    func getAddressString() -> String {
        var address = flatNo
        
        if address.isEmpty {
            address.append(houseNo)
        } else {
            address.append(", \(houseNo)")
        }
        
        if address.isEmpty {
            address.append(roadNo)
        } else {
            address.append(", \(roadNo)")
        }
        
        if address.isEmpty {
            address.append(addressLine)
        } else {
            address.append(", \(addressLine)")
        }
        
        if address.isEmpty {
            address.append("n/a")
        }
        
        return address
    }

}
