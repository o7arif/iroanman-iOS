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
    var firstName : String
    var lastName : String
    var gender : String
    var mobileVerifiedAt : String
    var alternativePhone : String
    var isActive : Bool
    
    override init() {
        self.id = 0
        self.name = ""
        self.email = ""
        self.mobile = ""
        self.profilePhoto = ""
        self.firstName = ""
        self.lastName = ""
        self.gender = ""
        self.mobileVerifiedAt = ""
        self.alternativePhone = ""
        self.isActive = false
    }
    
    convenience init(fromDictionary dictionary: [String:Any]?) {
        self.init()
        id = dictionary?["id"] as? Int ?? 0
        name = dictionary?["name"] as? String ?? ""
        email = dictionary?["email"] as? String ?? ""
        mobile = dictionary?["mobile"] as? String ?? ""
        profilePhoto = dictionary?["profile_photo_path"] as? String ?? ""
        firstName = dictionary?["first_name"] as? String ?? ""
        lastName = dictionary?["last_name"] as? String ?? ""
        gender = dictionary?["gender"] as? String ?? ""
        mobileVerifiedAt = dictionary?["mobile_verified_at"] as? String ?? ""
        alternativePhone = dictionary?["alternative_phone"] as? String ?? ""
        isActive = dictionary?["is_active"] as? Bool ?? false
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.mobile, forKey: "mobile")
        aCoder.encode(self.profilePhoto, forKey: "profile_photo_path")
        aCoder.encode(self.firstName, forKey: "first_name")
        aCoder.encode(self.lastName, forKey: "last_name")
        aCoder.encode(self.gender, forKey: "gender")
        aCoder.encode(self.mobileVerifiedAt, forKey: "mobile_verified_at")
        aCoder.encode(self.alternativePhone, forKey: "alternative_phone")
        aCoder.encode(self.isActive, forKey: "is_active")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        self.mobile = aDecoder.decodeObject(forKey: "mobile") as? String ?? ""
        self.profilePhoto = aDecoder.decodeObject(forKey: "profile_photo_path") as? String ?? ""
        self.firstName = aDecoder.decodeObject(forKey: "first_name") as? String ?? ""
        self.lastName = aDecoder.decodeObject(forKey: "last_name") as? String ?? ""
        self.gender = aDecoder.decodeObject(forKey: "gender") as? String ?? ""
        self.mobileVerifiedAt = aDecoder.decodeObject(forKey: "mobile_verified_at") as? String ?? ""
        self.alternativePhone = aDecoder.decodeObject(forKey: "alternative_phone") as? String ?? ""
        self.isActive = aDecoder.decodeBool(forKey: "is_active") as Bool
    }

}
