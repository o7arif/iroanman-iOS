//
//  ViewController.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/11/21.
//

import UIKit

class SplashVC: BaseVC {
    
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        
        startTimer()
    }

    private func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(redirectToNextScreen), userInfo: nil, repeats: false)
    }
    
    @objc private func redirectToNextScreen() {
        ElNavigato.instance.replaceWIndowByViewController(viewController: WelcomeVC())
        timer.invalidate()
    }

}

