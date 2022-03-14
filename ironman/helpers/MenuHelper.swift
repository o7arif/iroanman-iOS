//
//  MenuHelper.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/11/21.
//

import UIKit

class MenuHelper {
    
    static func getMenus(_ isLogged: Bool = false) -> [Menu] {
        var menus: [Menu] = []
        
        menus.append(Menu(name: L10n.Label.manageAddress, icon: UIImage(named: "ic_menu_address")!, type: MenuEnum.MANAGE_ADDRESS))
        
        menus.append(Menu(name: L10n.Label.privacyPolicy, icon: UIImage(named: "ic_menu_privacy_policy")!, type: MenuEnum.PRIVACY_POLICY))
        
        menus.append(Menu(name: L10n.Label.termsOfService, icon: UIImage(named: "ic_menu_terms_service")!, type: MenuEnum.TERMS_OF_SERVICE))
        
        menus.append(Menu(name: L10n.Label.contactUs, icon: UIImage(named: "ic_menu_contact")!, type: MenuEnum.CONTACT))
        
        menus.append(Menu(name: L10n.Label.about, icon: UIImage(named: "ic_menu_about")!, type: MenuEnum.ABOUT))
        
        if isLogged {
            menus.append(Menu(name: L10n.Label.logOut, icon: UIImage(named: "ic_menu_logout")!, type: MenuEnum.LOGOUT))
        }
        
        return menus
    }
}
