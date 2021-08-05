//
//  LoginVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/4/21.
//

import UIKit

class LoginVC: BaseVC {
    
    private let wrapperView = UIView()
    
    var phoneField : SmartTextField?
    var passwordField : SmartTextField?

    
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
        
        viewHeaderBack.addSubview(ivBack)
        ivBack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(ivBack.snp.bottom).offset(18)
        }

        viewHeaderBack.addSubview(labelHeaderSubTitle)
        labelHeaderSubTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(labelHeaderTitle.snp.bottom).offset(5)
        }
        
        phoneField = SmartTextField.init(placeholder: "Enter Phone Number", dataType: .name, validationType: .required, shouldAddMargin: true, leftIcon: "ic_phone")
        wrapperView.addSubview(phoneField!)
        phoneField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(35)
        }
        
        passwordField = SmartTextField.init(placeholder: "Enter your password", dataType: .password, validationType: .required, shouldAddMargin: true, leftIcon: "ic_lock")
        wrapperView.addSubview(passwordField!)
        passwordField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneField!.snp.bottom)
        }
        
        wrapperView.addSubview(labelForgotPassword)
        labelForgotPassword.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(passwordField!.snp.bottom).offset(20)
        }
        
        wrapperView.addSubview(btnLogin)
        btnLogin.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(labelForgotPassword.snp.bottom).offset(41)
            make.height.equalTo(50)
        }
        
        wrapperView.addSubview(labelSignup)
        labelSignup.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        print("back in tapped")
    }
    
    @objc private func loginTapped(_ sender: Any) {
        print("login tapped")
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
    
    private lazy var ivBack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_back")
        imageView.contentMode = .scaleAspectFit
        
        // click action
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTapped(_:)))
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Login"
        return label
    }()
    
    private let labelHeaderSubTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Please login to get our Service"
        return label
    }()
    
    private let labelForgotPassword: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Forgot password?"
        return label
    }()
    
    private let btnLogin: UIView = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
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
        button.addTarget(self, action: #selector(loginTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let labelSignup: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Don't have an Account? Sign up"
        return label
    }()
}
