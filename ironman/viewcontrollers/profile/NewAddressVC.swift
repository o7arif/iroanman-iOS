//
//  NewAddressVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import UIKit

class NewAddressVC: BaseVC {
    
    var isForEdit: Bool = false
    
    private var nameField : SmartTextField?
    private var areaDownPicker: SmartDownPicker?
    private var flatField : SmartTextField?
    private var houseField : SmartTextField?
    private var blockField : SmartTextField?
    private var roadField : SmartTextField?
    private var noteField : SmartTextField?
    
    override func viewDidLoad() {
        viewSetup()
        setupViews()
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
        
        if isForEdit {
            labelHeaderTitle.text = "Edit Address"
        }
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.right.equalToSuperview()
        }
        
        nameField = SmartTextField.init(placeholder: "Address Name (Ex. Office/Home/etc)", dataType: .name, validationType: .required, shouldAddMargin: true)
        container.addSubview(nameField!)
        nameField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(35)
        }
        
        areaDownPicker = SmartDownPicker.init(placeholder: "Area (Ex. Bashundhara)", dataSource: .gender, validationType: .required, shouldAddMargin: true)
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
        line25.backgroundColor = .red
        line25.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.5)
        }
        
        let line50 = UIView()
        flatToRoadContainer.addSubview(line50)
        line50.backgroundColor = .red
        line50.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1)
        }
        
        let line75 = UIView()
        flatToRoadContainer.addSubview(line75)
        line75.backgroundColor = .red
        line75.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.5)
        }
        
        // flat
        flatField = SmartTextField.init(placeholder: "Flat", dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(flatField!)
        flatField!.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(line25.snp.left)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // house
        houseField = SmartTextField.init(placeholder: "House", dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(houseField!)
        houseField!.snp.makeConstraints { make in
            make.left.equalTo(line25.snp.right)
            make.right.equalTo(line50.snp.left)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // block
        blockField = SmartTextField.init(placeholder: "Block", dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(blockField!)
        blockField!.snp.makeConstraints { make in
            make.left.equalTo(line50.snp.right)
            make.right.equalTo(line75.snp.left)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // block
        roadField = SmartTextField.init(placeholder: "Road", dataType: .name, validationType: .required, shouldAddMargin: false)
        flatToRoadContainer.addSubview(roadField!)
        roadField!.snp.makeConstraints { make in
            make.left.equalTo(line75.snp.right)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // additional note
        noteField = SmartTextField.init(placeholder: "Additional Note", dataType: .name, validationType: .optional, shouldAddMargin: true)
        container.addSubview(noteField!)
        noteField!.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(flatToRoadContainer.snp.bottom)
            make.height.equalTo(130)
        }
        
        container.addSubview(btnSaveAddress)
        btnSaveAddress.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(AppConst.buttonHeight)
        }
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveAddressTapped(_ sender: Any) {
        print("save address tapped")
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
        label.text = "Add New Address"
        return label
    }()
    
    private let btnSaveAddress: UIButton = {
        let button = UIButton()
        button.setTitle("Save Address", for: .normal)
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
