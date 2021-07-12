//
//  ElNavigato.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/12/21.
//

import UIKit


class ElNavigato {
    
    static let instance = ElNavigato()
    
    private init() {}
    
    func replaceWIndowByViewController(viewController: UIViewController){
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            window = UIApplication.shared.keyWindow
        }
        
        var options = UIWindow.TransitionOptions()
        options.direction = .toTop
        options.style = .easeOut
        window?.setRootViewController(NavigationController.init(rootViewController: viewController))
    }
}
