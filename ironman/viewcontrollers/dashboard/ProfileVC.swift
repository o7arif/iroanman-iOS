//
//  ProfileVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/6/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .yellow
        let label = UILabel()
        label.text = "Profile VC"
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
