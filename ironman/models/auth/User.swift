//
//  User.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 10/21/21.
//

import Foundation

@objc(User)
class User : NSObject, NSCoding {
    var id : Int
    var name : String
    var email : String
    var mobile : String
    var profilePhoto : String
    
    override init() {
        self.id = 0
        self.name = ""
        self.email = ""
        self.mobile = ""
        self.profilePhoto = ""
    }
    
    convenience init(fromDictionary dictionary: [String:Any]?) {
        self.init()
        id = dictionary?["id"] as? Int ?? 0
        name = dictionary?["name"] as? String ?? ""
        email = dictionary?["email"] as? String ?? ""
        mobile = dictionary?["mobile"] as? String ?? ""
        profilePhoto = dictionary?["profile_photo_path"] as? String ?? ""
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.mobile, forKey: "mobile")
        aCoder.encode(self.profilePhoto, forKey: "profile_photo_path")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        self.mobile = aDecoder.decodeObject(forKey: "mobile") as? String ?? ""
        self.profilePhoto = aDecoder.decodeObject(forKey: "profile_photo_path") as? String ?? ""
    }

}
