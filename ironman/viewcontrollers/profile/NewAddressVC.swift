//
//  NewAddressVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import UIKit
import Toaster

class NewAddressVC: BaseVC {
    
    var address: Address?
    
    private var nameField: SmartTextField?
    private var areaDownPicker: SmartDownPicker?
    private var flatField: SmartTextField?
    private var houseField: SmartTextField?
    private var blockField: SmartTextField?
    private var roadField: SmartTextField?
    private var noteField = NotesTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.backgroundColor = .color(fromHexString: "FAFAFA")
        
        setupViews()
        
        if address != nil {
            setAddressData()
        }
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
        
        nameField = SmartTextField.init(placeholder: L10n.Placeholder.addressNameExOfficeHomeEtc, dataType: .name, validationType: .required, shouldAddMargin: true, leftIcon: "ic_address_home")
        container.addSubview(nameField!)
        nameField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(35)
        }
        
        areaDownPicker = SmartDownPicker.init(placeholder: L10n.Placeholder.areaExBashundhara, dataSource: .area, validationType: .required, shouldAddMargin: true, leftIcon: "ic_map_pin")
        container.addSubview(areaDownPicker!)
        areaDownPicker!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameField!.snp.bottom)
        }
        
        let flatToRoadContainer = UIView()
        container.addSubview(flatToRoadContainer)
        flatToRoadContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(areaDownPicker!.snp.bottom)
        }
        
        let line25 = UIView()
        flatToRoadContainer.addSubview(line25)
        line25.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.5)
        }
        
        let line50 = UIView()
        flatToRoadContainer.addSubview(line50)
        line50.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1)
        }
        
        let line75 = UIView()
        flatToRoadContainer.addSubview(line75)
        line75.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.5)
        }
        
        // flat
        flatField = SmartTextField.init(placeholder: L10n.Placeholder.flat, dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(flatField!)
        flatField!.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(4)
            make.right.equalTo(line25.snp.left).offset(-12)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // house
        houseField = SmartTextField.init(placeholder: L10n.Placeholder.house, dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(houseField!)
        houseField!.snp.makeConstraints { make in
            make.left.equalTo(line25.snp.right)
            make.right.equalTo(line50.snp.left).offset(-6)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // block
        blockField = SmartTextField.init(placeholder: L10n.Placeholder.block, dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(blockField!)
        blockField!.snp.makeConstraints { make in
            make.left.equalTo(line50.snp.right).offset(6)
            make.right.equalTo(line75.snp.left)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // block
        roadField = SmartTextField.init(placeholder: L10n.Placeholder.road, dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(roadField!)
        roadField!.snp.makeConstraints { make in
            make.left.equalTo(line75.snp.right).offset(12)
            make.right.equalToSuperview().inset(4)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // additional note
        noteField.placeholder = L10n.Placeholder.additionalNote
        noteField.backgroundColor = .white
        noteField.font = OpenSans.regular.of(size: AppConst.fontSize14)
        container.addSubview(noteField)
        noteField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(AppConst.horizontalMargin)
            make.top.equalTo(flatToRoadContainer.snp.bottom).offset(10)
            make.height.equalTo(130)
        }
        
        container.addSubview(btnSaveAddress)
        btnSaveAddress.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(AppConst.buttonHeight)
        }
    }
    
    
    
    
    // MARK: SETUP DATA
    
    private func setAddressData() {
        labelHeaderTitle.text = L10n.Label.editAddress
        nameField?.textField.text = address?.addressName
        flatField?.textField.text = address?.flatNo
        houseField?.textField.text = address?.houseNo
        roadField?.textField.text = address?.roadNo
        blockField?.textField.text = address?.block
        noteField.text = address?.addressLine
    }
    
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveAddressTapped(_ sender: Any) {
        
        if isValid() {
            submitRequest()
        } else {
            print("not valid")
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
        label.text = L10n.Button.addNewAddress
        return label
    }()
    
    private let btnSaveAddress: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Button.saveAddress, for: .normal)
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
        button.addTarget(self, action: #selector(saveAddressTapped(_:)), for: .touchUpInside)
        return button
    }()
}





// MARK: DATA VALIDATION AND API CALLING

extension NewAddressVC {
    
    private func isValid() -> Bool {
        var valid = false
        
        let isNameValid = nameField?.isValid() ?? false
        let isFlatValid = flatField?.isValid() ?? false
        let isHouseValid = houseField?.isValid() ?? false
        let isRoadValid = roadField?.isValid() ?? false
        
        if isNameValid && isFlatValid && isHouseValid && isRoadValid {
            valid = true
        }
        
        return valid
    }
    
    
    private func submitRequest() {
        
        let parameters: [String: Any] = [
            "address_name": nameField?.textField.text ?? "",
            "house_no": houseField?.textField.text ?? "",
            "flat_no": flatField?.textField.text ?? "",
            "road_no": roadField?.textField.text ?? "",
            "address_line": noteField.text ?? ""
        ]
        
        
        
        if address == nil {
            // add new address
            Networking.instance.call(api: "addresses", method: .post, parameters: parameters) { (responseModel) in
                if responseModel.code == 200 {
                    Toast(text: responseModel.message).show()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.handleErrors(responseModel)
                }
            }
        } else {
            // update address
            Networking.instance.call(api: "addresses/\(address!.id)", method: .post, parameters: parameters) { (responseModel) in
                if responseModel.code == 200 {
                    Toast(text: responseModel.message).show()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.handleErrors(responseModel)
                }
            }
        }
        
    }
    
    
    
    private func handleErrors(_ responseModel: ResponseModel) {
        if responseModel.code == 401 {
            CacheData.instance.destroySession()
            return
        } else {
            for errorModel in responseModel.errors ?? [] {
                if errorModel.fieldName == "address_name" {
                    self.nameField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "road_no" {
                    self.roadField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "house_no" {
                    self.houseField!.setCustomErrorMessage(message: errorModel.message)
                } else if errorModel.fieldName == "flat_no" {
                    self.flatField!.setCustomErrorMessage(message: errorModel.message)
                }
            }
            if (responseModel.errors == nil || responseModel.errors?.count == 0) {
                Toast(text: responseModel.message ?? L10n.Label.unknownError).show()
            }
        }
    }
    
}
