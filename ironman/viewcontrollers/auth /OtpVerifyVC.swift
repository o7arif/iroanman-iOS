//
//  OtpVerifyVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/25/21.
//

import UIKit
import Toaster

public enum OtpSource: String {
    case signup = "signup"
    case forgot = "forgot"
    case none = "none"
}

class OtpVerifyVC: BaseVC {
    
    private var countDown = 60
    private var bidTimer: Timer?
    
    var number: String = ""
    var otpCode: Int = 0
    var otpSource: OtpSource = .none
    
    private var countTimer:Timer!
    private var counter = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let container = UIView()
        self.view.addSubview(container)
        container.backgroundColor = .color(fromHexString: "EFEFEF")
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(viewHeaderBack)
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
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(ivBack.snp.bottom).offset(10)
        }
        
        viewHeaderBack.addSubview(labelHeaderSubTitle)
        labelHeaderSubTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelHeaderTitle.snp.bottom).offset(5)
        }
        
        
        container.addSubview(OTPField)
        OTPField.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(44)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        container.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(88)
            make.height.equalTo(50)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func submitTapped(_ sender: Any) {
        
        guard let enteredOtp = Int(OTPField.text) else {
            return
        }
        
        verifyOTP(contact: number, otpCode: enteredOtp)
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
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.text = "OTP Verification"
        return label
    }()
    
    private let labelHeaderSubTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 18)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Enter the verification code we just sent you OTP on your Phone."
        return label
    }()
    
    private let OTPField: SmartOtpView = {
        let input = SmartOtpView()
        input.numberOfDigits = 4
        input.bottomBorderColor = .darkGray
        input.nextDigitBottomBorderColor = .primary
        input.textColor = .black
        input.acceptableCharacters = "0123456789"
        input.font = OpenSans.regular.of(size: AppConst.fontSize24)
        input.keyboardType = .numberPad
        input.animationType = .dissolve
        input.becomeFirstResponder()
        //        digitInput.keyboardAppearance = .dark
        return input
    }()
    
    private let labelOtpWillSendIn: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        label.text = "OTP will send within 00 : 30"
        return label
    }()
    
    private let labelResend: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .color(fromHexString: "FF4141")
        label.text = "Resend"
        return label
    }()
    
    private let btnSubmit: UIView = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
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
        button.addTarget(self, action: #selector(submitTapped(_:)), for: .touchUpInside)
        return button
    }()
}





// MARK: API CALLING

extension OtpVerifyVC {
    
    private func resendOtp(contact: String) {
        let api = "resend/otp"
        
        Networking.instance.call(api: api, method: .post, parameters: ["contact": contact] as [String:AnyObject]) { [weak self] (responseModel) in
            if (responseModel.code == 200) {
                DispatchQueue.main.async() {
                    if let message = responseModel.body["message"] as? String{
                        Toast(text: message).show()
                    }
                    if let dictionary = responseModel.body["data"] as? NSDictionary {
                        print("Q#_: get otp -> data dictionary = \(dictionary)")
                        
                        guard let otp = dictionary.value(forKey: "OTP") as? Int else {
                            print("Q#_: get otp -> otp from dictionary error")
                            return
                        }
                        print("Q#_: get otp -> otp = \(otp)")
                        self?.otpCode = otp
                    } else {
                        print("Q#_: get otp -> data dictionary parse error")
                    }
                }
            } else {
                if let message = responseModel.body["message"] as? String {
                    Toast(text: message).show()
                }
            }
        }
    }
    
    
    private func verifyOTP(contact: String, otpCode: Int) {
        
        var params = [
            "otp": otpCode
        ] as [String:Any]
        
        var api = ""
        
        if otpSource == .forgot {
            api = "forgot-password/otp/verify"
            params["mobile"] = contact
        } else {
            api = "contact/verify"
            params["contact"] = contact
        }
        
        Networking.instance.call(api: api, method: .post, parameters: params) { [weak self] responseModel in
            if (responseModel.code == 200) {
                print("Q#_: verify otp -> success")
                DispatchQueue.main.async() {
                    if let message = responseModel.body["message"] as? String{
                        Toast(text: message).show()
                    }
                    
                    switch self?.otpSource {
                    case .signup:
                        let vc = ProfilePhotoUploadVC()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    case .forgot:
                        let dictionary = responseModel.body["data"] as? NSDictionary ?? [:]
                        
                        if let token = dictionary["token"] as? String {
                            let vc = NewPasswordVC()
                            vc.token = token
                            self?.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            print("where is our token to reset password")
                        }
                    default:
                        break
                    }
                }
            } else {
                print("Q#_: verify otp -> failed")
                if let message = responseModel.body["message"] as? String {
                    Toast(text: message).show()
                }
            }
        }
    }
    
}
