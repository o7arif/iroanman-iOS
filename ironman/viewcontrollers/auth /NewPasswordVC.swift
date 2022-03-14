//
//  NewPasswordVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/8/21.
//

import UIKit
import Toaster

class NewPasswordVC: BaseVC {
    
    var token: String?
    
    private let wrapperView = UIView()
    
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
        
        passwordField = SmartTextField.init(placeholder: L10n.Placeholder.createNewPassword, dataType: .password, validationType: .required, shouldAddMargin: true, leftIcon: "ic_lock")
        wrapperView.addSubview(passwordField!)
        passwordField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(69)
        }
        
        confirmPasswordField = SmartTextField.init(placeholder: L10n.Placeholder.confirmNewPassword, dataType: .password, validationType: .required, shouldAddMargin: true, leftIcon: "ic_lock")
        wrapperView.addSubview(confirmPasswordField!)
        confirmPasswordField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordField!.snp.bottom)
        }
        
        wrapperView.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(confirmPasswordField!.snp.bottom).offset(44)
            make.height.equalTo(50)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmTapped(_ sender: Any) {
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
        label.text = L10n.Placeholder.createPassword
        return label
    }()
    
    private let labelHeaderSubTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = L10n.Label.createYourNewPassword
        return label
    }()
    
    private let btnConfirm: UIView = {
        let button = UIButton()
        button.setTitle(L10n.Button.confirm, for: .normal)
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




// MARK: VALIDATION & API CALLING

extension NewPasswordVC {
    
    private func isValid() -> Bool {
        let isPasswordValid = passwordField?.isValid() ?? false
        
        if !isPasswordValid {
            return false
        }
        
        let password = passwordField?.textField.text ?? ""
        let confirmPassword = confirmPasswordField?.textField.text ?? ""
        
        if password != confirmPassword {
            confirmPasswordField?.setCustomErrorMessage(message: L10n.Message.enterPhoneNumberToRecoverPassword)
            return false
        }
        
        return true
    }
    
    private func submitRequest() {
        let api = "reset-password"
        
        let params = [
            "token": token ?? "",
            "password": passwordField?.textField.text ?? "",
            "password_confirmation": confirmPasswordField?.textField.text ?? ""
        ] as [String: Any]
        
        Networking.instance.call(api: api, method: .post, parameters: params) { [weak self] (responseModel) in
            if (responseModel.code == 200) {
                let message = responseModel.body["message"] as? String
                DispatchQueue.main.async() {
                    let alert = UIAlertController(title: L10n.Label.alert, message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: L10n.Label.ok, style: .default, handler: { action in
                        switch action.style {
                        case .default:
                            let vc = LoginVC()
                            self?.navigationController?.pushViewController(vc, animated: true)
                        case .cancel:
                            break
                        case .destructive:
                            break
                        @unknown default:
                            break
                        }
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                if let message = responseModel.body["message"] as? String {
                    Toast(text: message).show()
                }
            }
        }
    }
    
}
