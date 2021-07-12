//
//  NavigationController.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/12/21.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: -200, vertical: 0), for: .default)
        self.navigationBar.isTranslucent = false

        #if swift(>=4.0)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        #elseif swift(>=3.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)];
        #endif
        self.navigationBar.tintColor = .white// UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
        
        //title color
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font : SFUIDisplay.regular.of(size: 20)]
//        navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
//        //solid color
        self.navigationBar.barTintColor = .primary
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
