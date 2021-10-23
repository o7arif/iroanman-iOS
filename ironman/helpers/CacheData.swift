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
    
    func setLoggedIn(loginData: LoginData) {
        if let user = loginData.user {
            saveLoggedUser(user: user)
        }
        
        if let access = loginData.access {
            saveAccess(access: access)
        }
    }
    
    func isLoggedIn() -> Bool {
        let access = getAccess()
        return access != nil
    }
    
    func destroySession() {
        UserDefaults.standard.set(nil, forKey: "user")
        UserDefaults.standard.set(nil, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    
    func saveLoggedUser(user: User) {
        guard let data = try? JSONEncoder().encode(user) else {
            fatalError("unable encode as data")
        }
        UserDefaults.standard.setValue(data, forKey: "logged_user")
        UserDefaults.standard.synchronize()
    }
    
    func getLoggedUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: "logged_user") else {
          // write your code as per your requirement
          return nil
        }
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
          fatalError("unable to decode this data")
        }
        return user
    }
    
    func saveAccess(access: Access) {
        guard let data = try? JSONEncoder().encode(access) else {
            fatalError("unable encode as data")
        }
        UserDefaults.standard.setValue(data, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    
    func getAccess() -> Access? {
        guard let data = UserDefaults.standard.data(forKey: "access_token") else {
          return nil
        }
        guard let access = try? JSONDecoder().decode(Access.self, from: data) else {
          fatalError("unable to decode this data")
        }
        return access
    }
    
}
