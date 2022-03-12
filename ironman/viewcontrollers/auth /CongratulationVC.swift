//
//  CongratulationVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/8/21.
//

import UIKit

class CongratulationVC: BaseVC {
    
    private let wrapperView = UIView()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.addSubview(wrapperView)
        wrapperView.backgroundColor = .white
        wrapperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapperView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(173)
        }
        
        wrapperView.addSubview(labelCongratulation)
        labelCongratulation.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).offset(26)
        }
        
        wrapperView.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelCongratulation.snp.bottom).offset(20)
        }
        
        wrapperView.addSubview(btnFinish)
        btnFinish.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(88)
            make.height.equalTo(50)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func finishTapped(_ sender: Any) {
//        CacheData.instance.setLoggedIn()
        ElNavigato.instance.replaceWIndowByViewController(viewController: TabNavigationVC())
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_congratulations")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelCongratulation: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = L10n.Label.congratulations
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = L10n.Message.youHaveSuccessfullySignedUpOnLaundryService
        return label
    }()
    
    private let btnFinish: UIView = {
        let button = UIButton()
        button.setTitle(L10n.Button.finish, for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(finishTapped(_:)), for: .touchUpInside)
        return button
    }()
    
}
