//
//  EditProfileVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/13/21.
//

import UIKit
import Toaster

class EditProfileVC: BaseVC {
    
    private var nameField : SmartTextField?
    private var genderDownPicker: SmartDownPicker?
    private var emailField : SmartTextField?
    private var phoneField : SmartTextField?
    private var altPhoneField : SmartTextField?
    
    private var imagePicker: ImagePicker!
    private var tempImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.backgroundColor = .color(fromHexString: "FAFAFA")
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        setupViews()
        setupData()
    }
    
    private func setupViews() {
        container.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        viewHeaderBack.addSubview(ivBack)
        ivBack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
        }
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.right.equalToSuperview()
        }
        
        container.addSubview(ivProfile)
        ivProfile.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        container.addSubview(ivCamera)
        ivCamera.snp.makeConstraints { make in
            make.bottom.equalTo(ivProfile.snp.bottom).inset(4)
            make.right.equalTo(ivProfile.snp.right).offset(8)
            make.height.width.equalTo(26)
        }
        
        nameField = SmartTextField.init(placeholder: "Your Name", dataType: .name, validationType: .required, shouldAddMargin: true)
        container.addSubview(nameField!)
        nameField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(ivProfile.snp.bottom).offset(35)
        }
        
        genderDownPicker = SmartDownPicker.init(placeholder: "Your Gender", dataSource: .gender, validationType: .required, shouldAddMargin: true)
        container.addSubview(genderDownPicker!)
        genderDownPicker!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameField!.snp.bottom)
        }
        
        emailField = SmartTextField.init(placeholder: "Email Address (Optional)", dataType: .email, validationType: .optional, shouldAddMargin: true)
        container.addSubview(emailField!)
        emailField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(genderDownPicker!.snp.bottom)
        }
        
        phoneField = SmartTextField.init(placeholder: "Enter Phone Number", dataType: .name, validationType: .required, shouldAddMargin: true)
        container.addSubview(phoneField!)
        phoneField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(emailField!.snp.bottom)
        }
        
        altPhoneField = SmartTextField.init(placeholder: "Alternative Phone (Optional)", dataType: .mobile, validationType: .optional, shouldAddMargin: true)
        container.addSubview(altPhoneField!)
        altPhoneField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneField!.snp.bottom)
        }
        
        container.addSubview(btnUpdateProfile)
        btnUpdateProfile.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(AppConst.buttonHeight)
        }
    }
    
    
    // MARK: SETUP DATA
    
    private func setupData() {
        guard let user = CacheData.instance.getLoggedUser() else {
            return
        }
        
        ivProfile.load(url: URL(string: user.profilePhoto)!)
        
        nameField?.textField.text = user.name
        emailField?.textField.text = user.email
        phoneField?.textField.text = user.mobile
        phoneField?.textField.isEnabled = false
        altPhoneField?.textField.text = user.alternativePhone
        
        let gender: String = user.gender
        if !gender.isEmpty {
            let index = genderDownPicker?.getIndex(item: gender) ?? -1
            genderDownPicker?.setIndex(i: index)
            genderDownPicker?.setTitle(title: gender)
        }
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func cameraTapped(_ sender: UIView) {
        imagePicker.present(from: sender)
    }
    
    @objc private func updateProfileTapped(_ sender: Any) {
        
        if isValid() {
            updateProfile()
        }
        
    }
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
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
    
    private let viewHeaderBack: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.semiBold.of(size: 20)     // should be Poppins Semibold 20
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Edit Profile"
        return label
    }()
    
    private let ivProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_profile")
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.color(fromHexString: "F2F2F2").cgColor
        imageView.layer.backgroundColor = UIColor.color(fromHexString: "F2F2F2").cgColor
        imageView.layer.shadowColor = UIColor.color(fromHexString: "555555").cgColor
        imageView.layer.shadowOffset = CGSize(width: 1, height: 2)
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowRadius = 20
        imageView.layer.masksToBounds = true
        //        imageView.clipsToBounds = false
        return imageView
    }()
    
    private lazy var ivCamera: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_camera")
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.cornerRadius = 13
        imageView.layer.masksToBounds = true
        
        // click event
        let tap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(_:)))
        tap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private let btnUpdateProfile: UIButton = {
        let button = UIButton()
        button.setTitle("Update Profile", for: .normal)
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
        button.addTarget(self, action: #selector(updateProfileTapped(_:)), for: .touchUpInside)
        return button
    }()
    
}




// MARK: IMAGE PICKER

extension EditProfileVC: ImagePickerDelegate {
    
    // image picker selected photo listener
    func didSelect(image: UIImage?) {
        if image == nil {
            self.tempImage = nil
            return
        }
        
        let tempImage = image!.resized(to: CGSize(width: 512, height: 512))
        self.tempImage = tempImage
        
        ivProfile.image = tempImage
    }
    
}





// MARK: API CALLING

extension EditProfileVC {
    
    private func isValid() -> Bool {
        
        let isNameValid = nameField?.isValid() ?? false
        let isPhoneValid = phoneField?.isValid() ?? false
        let isGenderValid = genderDownPicker?.isValid() ?? false
        
        if !isNameValid || !isPhoneValid || !isGenderValid {
            return false
        }
        
        if emailField?.textField.text?.count ?? 0 > 0 {
            let isEmailValid = emailField?.isValid() ?? false
            if !isEmailValid {
                return false
            }
        }
        
        if altPhoneField?.textField.text?.count ?? 0 > 0 {
            let isAltPhoneValid = altPhoneField?.isValid() ?? false
            if !isAltPhoneValid {
                return false
            }
        }
        
        return true
    }
    
    private func updateProfile() {
        let params = generateParams()
        
        var imgData:[Data] = []
        if tempImage != nil  {
            
            guard let data = tempImage?.jpegData(compressionQuality: 100) else {
                Toast(text: "Something went wrong during Photo fetching from gallery").show()
                return
            }
            
            imgData.append(data)
        }
        
        Networking.instance.callMutipartMultipleFilesWithParameters(api: "users/update", method: .post, imageDatas: imgData, dataKey: "profile_photo", parameters: params) { (responseModel) in
            if responseModel?.code == 200 {
                if let dictionary = responseModel?.body["data"] as? Dictionary<String, AnyObject> {
                    Toast(text: responseModel?.body["message"] as? String ?? "Profile update successful").show()
                    
                    if let userDictionary = dictionary["user"] as? [String:Any] {
                        let userModel = User.init(fromDictionary: userDictionary)
                        CacheData.instance.saveLoggedUser(user: userModel)
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                } else {
                    Toast(text: "Something went wrong. Please try again later.").show()
                }
            } else {
                self.handleErrors(responseModel)
            }
        }
        
    }
    
    
    private func generateParams() -> [String:Any] {
        let params = [
            "first_name": nameField?.textField.text ?? "",
            "gender": genderDownPicker?.getTitle() ?? "",
            "email": emailField?.textField.text ?? "",
            "alternative_phone": altPhoneField?.textField.text ?? ""
        ] as [String:Any]
        return params
    }
    
    
    private func handleErrors(_ responseModel: ResponseModel?) {
        if responseModel == nil {
            Toast(text: "Something went wrong. Please try again later.").show()
            return
        }
        
        if responseModel!.code == 401 {
            CacheData.instance.destroySession()
            return
        } else {
            for errorModel in responseModel!.errors ?? [] {
                if errorModel.fieldName == "first_name" {
                    self.nameField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "mobile" {
                    self.phoneField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "email" {
                    self.emailField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "alternative_phone" {
                    self.altPhoneField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "gender" {
                    self.genderDownPicker!.setCustomErrorMessage(message: errorModel.message)
                }
            }
            if (responseModel!.errors == nil || responseModel!.errors?.count == 0) {
                Toast(text: responseModel!.message ?? "message_not_found").show()
            }
        }
    }
    
}
