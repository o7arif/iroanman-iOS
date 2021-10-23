//
//  ProfilePhotoUploadVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/8/21.
//

import UIKit

class ProfilePhotoUploadVC: BaseVC {
    
    private let wrapperView = UIView()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.addSubview(wrapperView)
        wrapperView.backgroundColor = .color(fromHexString: "EFEFEF")
        wrapperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
        wrapperView.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(230)
        }
        
        viewHeaderBack.addSubview(labelSkip)
        labelSkip.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelSkip.snp.bottom).offset(18)
        }

        viewHeaderBack.addSubview(labelHeaderSubTitle)
        labelHeaderSubTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelHeaderTitle.snp.bottom).offset(5)
        }
        
        wrapperView.addSubview(ivUserProfile)
        ivUserProfile.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        wrapperView.addSubview(ivCamera)
        ivCamera.snp.makeConstraints { make in
            make.bottom.equalTo(ivUserProfile.snp.bottom)
            make.right.equalTo(ivUserProfile.snp.right)
        }
        
        wrapperView.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(88)
            make.height.equalTo(50)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func skipTapped(_ sender: Any) {
//        CacheData.instance.setLoggedIn()
        ElNavigato.instance.replaceWIndowByViewController(viewController: TabNavigationVC())
    }
    
    @objc private func cameraTapped(_ sender: Any) {
        print("camera tapped")
    }
    
    @objc private func confirmTapped(_ sender: Any) {
        self.navigationController?.pushViewController(CongratulationVC(), animated: true)
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let viewHeaderBack: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    
    private lazy var labelSkip: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Skip"
        
        // click event
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(skipTapped(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Do you want add your profile photo?"
        return label
    }()
    
    private let labelHeaderSubTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Please add your photo/Capture."
        return label
    }()
    
    private let ivUserProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "ic_profile_photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var ivCamera: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_camera")
        
        // click event
        let tap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(_:)))
        tap.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private let btnConfirm: UIView = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
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
        button.addTarget(self, action: #selector(confirmTapped(_:)), for: .touchUpInside)
        return button
    }()
}
