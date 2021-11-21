//
//  CacheData.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/8/21.
//

import Foundation

class CacheData {
    
    static let instance = CacheData()
    
    private init() {}
    
    func isLoggedIn() -> Bool {
        return !getToken().isEmpty
    }
    
    func destroySession() {
        UserDefaults.standard.set(nil, forKey: "user_data")
        UserDefaults.standard.set(nil, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    
    func saveLoggedUser(user: User) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "user_data")
            UserDefaults.standard.synchronize()
        } catch {
            print("")
        }
    }
    
    func getLoggedUser() -> User? {
        guard let encodedData = UserDefaults.standard.object(forKey: "user_data") else {
            return nil
        }
        do {
            let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData as! Data) as? User
            return user
        } catch {
            return nil
        }
    }
    
    func saveAccess(access: Access) {
        UserDefaults.standard.setValue(access.token, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    
    func getToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: "access_token") else {
          return ""
        }
        return token
    }
    
}
