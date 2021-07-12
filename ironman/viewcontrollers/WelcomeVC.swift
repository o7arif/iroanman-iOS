//
//  WelcomeVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/12/21.
//

import UIKit
import SnapKit

class WelcomeVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let container = UIView()
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // bold
        let bold = UILabel()
        bold.text = "bold"
        bold.font = OpenSans.bold.of(size: 14)
        container.addSubview(bold)
        bold.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        // bold italic
        let boldItalic = UILabel()
        boldItalic.text = "bold italic"
        boldItalic.font = OpenSans.boldItalic.of(size: 14)
        container.addSubview(boldItalic)
        boldItalic.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(bold.snp.bottom).offset(4)
        }

        // extra bold
        let extraBold = UILabel()
        extraBold.text = "extra bold"
        extraBold.font = OpenSans.extraBold.of(size: 14)
        container.addSubview(extraBold)
        extraBold.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(boldItalic.snp.bottom).offset(4)
        }

        // extra bold italic
        let extraBoldItalic = UILabel()
        extraBoldItalic.text = "extra bold italic"
        extraBoldItalic.font = OpenSans.extraBoldItalic.of(size: 14)
        container.addSubview(extraBoldItalic)
        extraBoldItalic.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(extraBold.snp.bottom).offset(4)
        }

        // italic
        let italic = UILabel()
        italic.text = "italic"
        italic.font = OpenSans.italic.of(size: 14)
        container.addSubview(italic)
        italic.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(extraBoldItalic.snp.bottom).offset(4)
        }

        // light
        let light = UILabel()
        light.text = "light"
        light.font = OpenSans.light.of(size: 14)
        container.addSubview(light)
        light.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(italic.snp.bottom).offset(4)
        }

        // light italic
        let lightItalic = UILabel()
        lightItalic.text = "light italic"
        lightItalic.font = OpenSans.lightItalic.of(size: 14)
        container.addSubview(lightItalic)
        lightItalic.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(light.snp.bottom).offset(4)
        }

        // regular
        let regular = UILabel()
        regular.text = "regular"
        regular.font = OpenSans.regular.of(size: 14)
        container.addSubview(regular)
        regular.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(lightItalic.snp.bottom).offset(4)
        }

        // semi bold
        let semiBold = UILabel()
        semiBold.text = "semi bold"
        semiBold.font = OpenSans.semiBold.of(size: 14)
        container.addSubview(semiBold)
        semiBold.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(regular.snp.bottom).offset(4)
        }

        // semi bold italic
        let semiBoldItalic = UILabel()
        semiBoldItalic.text = "semi bold italic"
        semiBoldItalic.font = OpenSans.semiBoldItalic.of(size: 14)
        container.addSubview(semiBoldItalic)
        semiBoldItalic.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(semiBold.snp.bottom).offset(4)
        }
        
    }
    
    
}
