//
//  BaseVC.swift
//  ironman
//
//  Created by Shofikul Islam on 04/08/2021.
//

import UIKit



class BaseVC: UIViewController {
    let container = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        if (self.shouldHideKeyboardOnTouch){
//            hideKeyboardOnViewTouchSetup()
//        }
//
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    
   

    
    
    func viewSetup(){
    
        self.view.addSubview(container)
        container.backgroundColor = .color(fromHexString: "EFEFEF")
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    

    
   
    @objc func backButtonTap(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
