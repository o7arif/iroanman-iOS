//
//  AppConst.swift
//  ironman
//
//  Created by Shofikul Islam on 04/08/2021.
//

import UIKit

struct AppConst {
    
    static let BASE_URL = "http://admin.ironmandev.xyz/api/"
    
    static let horizontalMargin = 24
    static let verticalMargin = 8
    static let buttonHeight = 50
    static let bottomMarginFactor = 60
    static let basicControlHeight = 60
    static let auctionRowHeight = 50
    static let auctionLendersLogoHeight = 30
    static let infoCellHeight = 70
    static let fieldHeight = 90
    
    static let inputField = 50

    static let dropdownHeight = 70
    
    // im not clear data
    static var i_need_sugeestion = false
    
    
    
    
    
    
    static func heightBottomSheet() -> Int{
        if #available(iOS 11.0, *) {
            
            return Int(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0)
            
        }
        else { return 0 }
    }
    
    
    
    static func safeAreaTop() -> Int{
        if #available(iOS 11.0, *) {
            return Int(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) }
        else { return 0 }
    }
    static func safeAreaBottom() -> Int{
        if #available(iOS 11.0, *) {
            
            var actionBarHeight: Int = Int(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
            
            print("actionBarHeight: \(actionBarHeight)")
            if (actionBarHeight == 0){
                actionBarHeight = 20
            }
            
            
            return actionBarHeight
            
        }
        else { return 0 }
    }
    
    
    
    static func loginTopHeader() -> Int{
        if #available(iOS 11.0, *) {
            var actionBarHeight: Int = Int(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
            print("actionBarHeight: \(actionBarHeight)")
            if (actionBarHeight == 0){
                actionBarHeight = 30
            }else {
                actionBarHeight = 50
                
                
            }
            
            
            return actionBarHeight
            
        }
        else { return 0 }
    }
    
    
    
    
    
//    static func headerHeight() -> Int{
//        if #available(iOS 11.0, *) {
//
//            var headerHeight: Int = 100
//            let actionBarHeight: Int = Int(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
//            if (actionBarHeight == 0){
//                headerHeight = 73
//            }
//
//
//            return headerHeight
//
//        }
//        else { return 0 }
//    }
//
    
    static func logingViewBodyHeight() -> Int{
        if #available(iOS 11.0, *) {
            var actionBarHeight: Int = Int(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
            // mini Device
            if (actionBarHeight == 0){
                actionBarHeight = 150
            }else{
                actionBarHeight = 210
            }
            
            
            return actionBarHeight
            
        }
        else { return 0 }
    }
    
    
    static func loginViewHeaderHight() -> Int{
        if #available(iOS 11.0, *) {
            var actionBarHeight: Int = Int(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
            // mini Device
            
            print("actionBarHeight:\(actionBarHeight)")
            
            if (actionBarHeight == 0){
                actionBarHeight = 0
                
            }else{
                actionBarHeight = 20
            }
            
            return actionBarHeight
            
        }
        else { return 0 }
    }
    
    
    
    static let fontSize25: CGFloat = 25.00
    static let fontSize24: CGFloat = 21.30
    static let fontSize22: CGFloat = 19.52
    static let fontSize20: CGFloat = 20.00

    static let fontSize18: CGFloat = 18.00
    static let fontSize16: CGFloat = 16.00
    static let fontSize14: CGFloat = 14.00
    static let fontSize12: CGFloat = 12.00
    static let fontSize10: CGFloat = 10.00

    static let takaSymbol = "৳"
    
    
    
    
}
