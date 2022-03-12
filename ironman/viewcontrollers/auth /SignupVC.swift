//
//  SignupVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/8/21.
//

import UIKit
import Alamofire
import Toaster

class SignupVC: BaseVC {
    
    private let wrapperView = UIView()
    
    var nameField : SmartTextField?
    var phoneField : SmartTextField?
    var passwordField : SmartTextField?
    var confirmPasswordField : SmartTextField?

    
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
        
        nameField = SmartTextField.init(placeholder: L10n.Placeholder.yourName, dataType: .name, validationType: .required, shouldAddMargin: true, leftIcon: "ic_person")
        wrapperView.addSubview(nameField!)
        nameField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(35)
        }
        
        phoneField = SmartTextField.init(placeholder: L10n.Placeholder.enterPhoneNumber, dataType: .name, validationType: .required, shouldAddMargin: true, leftIcon: "ic_phone")
        wrapperView.addSubview(phoneField!)
        phoneField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameField!.snp.bottom)
        }
        
        passwordField = SmartTextField.init(placeholder: L10n.Placeholder.createPassword, dataType: .password, validationType: .required, shouldAddMargin: true, leftIcon: "ic_lock")
        wrapperView.addSubview(passwordField!)
        passwordField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneField!.snp.bottom)
        }
        
        confirmPasswordField = SmartTextField.init(placeholder: L10n.Placeholder.confirmPassword, dataType: .password, validationType: .required, shouldAddMargin: true, leftIcon: "ic_lock")
        wrapperView.addSubview(confirmPasswordField!)
        confirmPasswordField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordField!.snp.bottom)
        }
        
        wrapperView.addSubview(btnSignup)
        btnSignup.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(confirmPasswordField!.snp.bottom).offset(41)
            make.height.equalTo(50)
        }
        
        wrapperView.addSubview(labelLogin)
        labelLogin.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func loginTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func signupTapped(_ sender: Any) {
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
        label.text = L10n.Label.SignUp
        return label
    }()
    
    private let labelHeaderSubTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = L10n.Message.pleaseRegisterToGetOurService
        return label
    }()
    
    private let btnSignup: UIView = {
        let button = UIButton()
        button.setTitle(L10n.Label.SignUp, for: .normal)
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
        button.addTarget(self, action: #selector(signupTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = L10n.Message.alreadyHaveAnAccountLoginNow
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapped(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
}





// MARK: DATA VALIDATION AND API CALLING

extension SignupVC {
    
    private func isValid() -> Bool {
        var valid = false
        
        let isNameValid = nameField?.isValid() ?? false
        let isPhoneValid = phoneField?.isValid() ?? false
        let isPasswordValid = passwordField?.isValid() ?? false
        let isConfirmPasswordValid = confirmPasswordField?.isValid() ?? false
        
        if isNameValid && isPhoneValid && isPasswordValid && isConfirmPasswordValid {
            valid = true
        }
        
        return valid
    }
    
    
    
    private func submitRequest() {
     
        let parameters = [
            "first_name": nameField?.textField.text ?? "",
            "mobile": phoneField?.textField.text ?? "",
            "password": passwordField?.textField.text ?? "",
            "password_confirmation": confirmPasswordField?.textField.text ?? ""
        ] as [String: Any]
        
        Networking.instance.call(api: "register", method: .post, parameters: parameters) { (responseModel) in
            if(responseModel.code == 200) {
                guard let dictionary = responseModel.body["data"] as? NSDictionary else {
                    print("Empty body")
                    Toast(text: responseModel.message ?? L10n.Message.somethingWentWrongPleaseTryAgainLater).show()
                    return
                }
                
                guard let message = responseModel.body["message"] as? String else {
                    print("Empty message")
                    Toast(text: responseModel.message ?? L10n.Message.somethingWentWrongPleaseTryAgainLater).show()
                    return
                }
               
                guard let userDictionary = dictionary["user"] as? [String:Any] else {
                    print("Empty user")
                    Toast(text: responseModel.message ?? L10n.Message.somethingWentWrongPleaseTryAgainLater).show()
                    return
                }
                
                guard let accessDictionary = dictionary["access"] as? [String:Any] else {
                    print("Empty access")
                    Toast(text: responseModel.message ?? L10n.Message.somethingWentWrongPleaseTryAgainLater).show()
                    return
                }
                
                if let _ = accessDictionary["token"] {
                    
                    let userModel = User.init(fromDictionary: userDictionary)
                    let access = Access.init(fromDictionary: accessDictionary)
                    
                    CacheData.instance.saveLoggedUser(user: userModel)
                    CacheData.instance.saveAccess(access: access)
                    
                    Toast(text: message).show()
                    
                    // TODO: Goto OTP verfication
                    let vc = OtpVerifyVC()
                    vc.otpSource = .signup
                    vc.number = userModel.mobile
                    self.navigationController?.pushViewController(vc, animated: true)
//                    ElNavigato.instance.replaceWIndowByViewController(viewController: TabNavigationVC())
                } else {
                    print("something wrong with bearer token")
                }
                
            } else {
                self.handleErrors(responseModel)
            }
        }
        
    }
    
    
    
    private func handleErrors(_ responseModel: ResponseModel) {
        if responseModel.code == 401 {
            CacheData.instance.destroySession()
            return
        } else {
            for errorModel in responseModel.errors ?? [] {
                if errorModel.fieldName == "first_name" {
                    self.nameField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "mobile" {
                    self.phoneField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "password" {
                    self.passwordField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "password_confirmation" {
                    self.confirmPasswordField!.setCustomErrorMessage(message: errorModel.message)
                }
            }
            if (responseModel.errors == nil || responseModel.errors?.count == 0) {
                Toast(text: responseModel.message ?? L10n.Label.unknownError).show()
            }
        }
    }
    
}

