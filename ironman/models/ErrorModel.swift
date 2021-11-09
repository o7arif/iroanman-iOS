//
//  ErrorModel.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/10/21.
//

import Foundation

class ErrorModel{
    
    public var fieldName: String
    public var message: String
    
    init(fieldName: String, message: String) {
        self.fieldName = fieldName
        self.message = message
    }
    
}
