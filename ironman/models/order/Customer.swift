//
//  Customer.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/21/21.
//

struct Customer {
    
    var user: User
    var addresses: [Address]
    
    init() {
        user = User()
        addresses = [Address]()
    }
    
    init(fromDictionary dictionary: [String:Any]?) {
        self.init()
        let userDictionary = dictionary?["user"] as?  [String:Any]
        user = User.init(fromDictionary: userDictionary)
        
        if let addressesDictionary = dictionary?["experiences"] as? [[String:Any]] {
            for addressDictionary in addressesDictionary {
                self.addresses.append(Address.init(fromDictionary: addressDictionary))
            }
        }
        
    }
    
    
}
