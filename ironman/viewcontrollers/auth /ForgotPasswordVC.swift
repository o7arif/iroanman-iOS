//
//  ForgotPasswordVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/8/21.
//

import UIKit
import Toaster

class ForgotPasswordVC: BaseVC {
    
    private let wrapperView = UIView()
    
    var phoneField : SmartTextField?
    
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
        
        phoneField = SmartTextField.init(placeholder: L10n.Placeholder.enterPhoneNumber, dataType: .name, validationType: .required, shouldAddMargin: true, leftIcon: "ic_phone")
        wrapperView.addSubview(phoneField!)
        phoneField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(95)
        }
        
        wrapperView.addSubview(btnSendOtp)
        btnSendOtp.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(phoneField!.snp.bottom).offset(88)
            make.height.equalTo(50)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendOtpTapped(_ sender: Any) {
        if isValid() {
            forgotPassword(contact: phoneField?.textField.text ?? "")
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
        label.text = L10n.Label.recoverPassword
        return label
    }()
    
    private let labelHeaderSubTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = L10n.Message.enterPhoneNumberToRecoverPassword
        return label
    }()
    
    private let btnSendOtp: UIView = {
        let button = UIButton()
        button.setTitle(L10n.Button.sendOTP, for: .normal)
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
        button.addTarget(self, action: #selector(sendOtpTapped(_:)), for: .touchUpInside)
        return button
    }()
}




// MARK: VALIDATION & API CALLING

extension ForgotPasswordVC {
    
    private func isValid() -> Bool {
        let isPhoneValid = phoneField?.isValid() ?? false
        if isPhoneValid {
            return true
        }
        return false
    }
    
    private func forgotPassword(contact: String) {
        let api = "forgot-password"
        
        Networking.instance.call(api: api, method: .post, parameters: ["mobile": contact] as [String:AnyObject]) { [weak self] (responseModel) in
            if (responseModel.code == 200) {
                DispatchQueue.main.async() {
                    let vc = OtpVerifyVC()
                    vc.otpSource = .forgot
                    vc.number = contact
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                if let message = responseModel.body["message"] as? String {
                    Toast(text: message).show()
                }
            }
        }
    }
    
}
