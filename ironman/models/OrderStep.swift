//
//  OrderStep.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 9/10/21.
//

import Foundation

struct OrderStep {
    var name: String
    var date: String
    var time: String    // need to remove this field on development, time should be parse from date string
    var isCompleted: Bool   // this is not necessary on development, it should be detemine by date, we can say this step is not complete if there is no date available.
}
