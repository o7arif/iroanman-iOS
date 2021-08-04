//
//  LoginVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/4/21.
//

import UIKit

class LoginVC: BaseVC {
    
    private let wrapperView = UIView()
    
    var emailOrPhoneField : SmartTextField?

    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.addSubview(wrapperView)
        wrapperView.backgroundColor = .color(fromHexString: "E4E4E4")
        wrapperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
        
        
//        wrapperView.addSubview(viewHeaderBack)
//        viewHeaderBack.addSubview(ivBack)
//        ivBack.snp.makeConstraints { make in
//            make.left.equalToSuperview().inset(20)
//            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
//        }
//
//        viewHeaderBack.addSubview(labelHeaderTitle)
//        labelHeaderTitle.snp.makeConstraints { make in
//            make.left.equalToSuperview().inset(20)
//            make.top.equalTo(ivBack.snp.bottom).offset(18)
//        }
//
//        viewHeaderBack.addSubview(labelHeaderSubTitle)
//        labelHeaderSubTitle.snp.makeConstraints { make in
//            make.left.equalToSuperview().inset(20)
//            make.top.equalTo(labelHeaderTitle.snp.bottom).offset(5)
//        }
//
        
        
        emailOrPhoneField = SmartTextField.init(placeholder: "User Name", dataType: .name, validationType: .required,shouldAddMargin: true, leftIcon: "ic_phone")
        wrapperView.addSubview(emailOrPhoneField!)
        emailOrPhoneField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }

        

//        container.addSubview(tvPhoneNumber)
//        tvPhoneNumber.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(20)
//            make.centerY.equalToSuperview()
//            make.height.equalTo(50)
//        }
//
//        container.addSubview(btnSendOTP)
//        btnSendOTP.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(30)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-35)
//            make.height.equalTo(50)
//        }
//
        
        
        
        
        
        

    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        print("back in tapped")
    }
    
    @objc private func sendOtpTapped(_ sender: Any) {
        print("send otp tapped")
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
    
    private let tvPhoneNumber: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Enter Phone Number"
        textField.backgroundColor = .white
        textField.keyboardType = UIKeyboardType.phonePad
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = OpenSans.regular.of(size: 14)
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.layer.cornerRadius = 10
        
        textField.layer.shadowColor = UIColor.color(fromHexString: "A7A8A9").cgColor
        textField.layer.shadowOffset = CGSize(width: 1, height: 2)
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowRadius = 10
        textField.layer.masksToBounds = false
        
        let image = UIImage(systemName: "phone.fill")
        
        
        
        textField.leftView?.addSubview(UIImageView(image: image))
        textField.leftView?.tintColor = .black
                
        return textField
    }()
    
    private let btnSendOTP: UIView = {
        let button = UIButton()
        button.setTitle("Send OTP", for: .normal)
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
