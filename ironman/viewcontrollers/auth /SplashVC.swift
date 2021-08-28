//
//  ViewController.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/11/21.
//

import UIKit
import Gifu

class SplashVC: BaseVC {
    
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.pushViewController(ChooseItemVC(), animated: true)
        
        self.view.addSubview(ivSplash)
        ivSplash.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    // MARK: ACTIONS
    
    @objc private func redirectToNextScreen() {
        if CacheData.instance.isLoggedIn() {
            ElNavigato.instance.replaceWIndowByViewController(viewController: TabNavigationVC())
        } else {
            ElNavigato.instance.replaceWIndowByViewController(viewController: WelcomeVC())
        }
        timer.invalidate()
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivSplash: GIFImageView = {
        let imageView = GIFImageView()
        imageView.animate(withGIFNamed: "splash_animation", loopCount: 1, animationBlock:  {
//            self.redirectToNextScreen()
        })
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

}

