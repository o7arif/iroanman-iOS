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
    
    func setLoggedIn() {
        UserDefaults.standard.setValue(true, forKey: "is_logged")
        UserDefaults.standard.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        let logged = UserDefaults.standard.value(forKey: "is_logged") as? Bool ?? false
        return logged
    }
    
    func destroySession() {
        UserDefaults.standard.set(nil, forKey: "is_logged")
        UserDefaults.standard.synchronize()
    }
    
}
