//
//  ResponseModel.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/10/21.
//

import Foundation

class ResponseModel {
    
    public var code: Int
    public var body: NSDictionary
    public var message: String?
    public var errors: [ErrorModel]?
    
    init(code: Int, body: NSDictionary, message: String? = "", errors: [ErrorModel]? = []) {
        self.code = code
        self.body = body
        self.message = message
        self.errors = errors
        
        if self.message == "" {
            if let massage = body["message"] as? String {
                self.message = massage
            }
        }
    }
    
}
