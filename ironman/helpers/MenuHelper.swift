//
//  MenuHelper.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/11/21.
//

import UIKit

class MenuHelper {
    
    static func getMenus() -> [Menu] {
        var menus: [Menu] = []
        
        menus.append(Menu(name: MenuEnum.MANAGE_ADDRESS.rawValue, icon: UIImage(named: "ic_menu_address")!))
        
        menus.append(Menu(name: MenuEnum.PRIVACY_POLICY.rawValue, icon: UIImage(named: "ic_menu_privacy_policy")!))
        
        menus.append(Menu(name: MenuEnum.TERMS_OF_SERVICE.rawValue, icon: UIImage(named: "ic_menu_terms_service")!))
        
        menus.append(Menu(name: MenuEnum.CONTACT.rawValue, icon: UIImage(named: "ic_menu_contact")!))
        
        menus.append(Menu(name: MenuEnum.ABOUT.rawValue, icon: UIImage(named: "ic_menu_about")!))
        
        return menus
    }
}
