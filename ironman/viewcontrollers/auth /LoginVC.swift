//
//  LoginVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/4/21.
//

import UIKit
import Alamofire
import Toaster

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
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func signupTapped(_ sender: Any) {
        self.navigationController?.pushViewController(SignupVC(), animated: true)
    }
    
    @objc private func forgotPasswordTapped(_ sender: Any) {
        self.navigationController?.pushViewController(ForgotPasswordVC(), animated: true)
    }
    
    @objc private func loginTapped(_ sender: Any) {
        if isValid() {
            submitRequest()
        }
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
    
    private lazy var labelForgotPassword: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Forgot password?"
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped(_:)))
        label.addGestureRecognizer(tap)
        
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
    
    private lazy var labelSignup: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Don't have an Account? Sign up"
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(signupTapped(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
}





// MARK: DATA VALIDATION AND API CALLING

extension LoginVC {
    
    private func isValid() -> Bool {
        var valid = false
        
        let isPhoneValid = phoneField?.isValid() ?? false
        let isPasswordValid = passwordField?.isValid() ?? false
        
        if isPhoneValid && isPasswordValid {
            valid = true
        }
        
        return valid
    }
    
    
    
    private func submitRequest() {
        
        guard let url = URL(string: AppConst.BASE_URL + "/login") else {
          return
        }
        
        let parameters: [String: Any] = [
            "contact": phoneField?.textField.text ?? "",
            "password": passwordField?.textField.text ?? ""
        ]
        
        let request = AF.request(url, method: .post, parameters: parameters)
        
        request.responseDecodable(of: LoginResponse.self) { (response) in
            guard let loginResponse = response.value else {
                print("Empty Response")
                Toast(text: response.error?.localizedDescription ?? "Something went wrong. Please try again later.").show()
                return
            }
            
            guard let loginData = loginResponse.loginData else {
                Toast(text: loginResponse.message ?? "Something went wrong. Please try again later").show()
                print("Empty Login Data")
                return
            }
            
//            guard let user = loginData.user else {
//                print("Empty User")
//                return
//            }
//
//            guard let access = loginData.access else {
//                print("Empty Access")
//                return
//            }
            
            CacheData.instance.setLoggedIn(loginData: loginData)
            ElNavigato.instance.replaceWIndowByViewController(viewController: TabNavigationVC())
        }
    }
}
