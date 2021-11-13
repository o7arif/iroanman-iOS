//
//  AddressTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import UIKit

protocol AddressDelegate {
    func addressEditTapped(address: Address)
    func addressDeleteTapped(address: Address)
}

class AddressTVCell: UITableViewCell {
    
    static let identifier = "AddressTVCell"
    
    private var listener: AddressDelegate?
    private var address: Address?
    
    private let container = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .color(fromHexString: "FAFAFA")
    
        self.contentView.addSubview(container)
        container.backgroundColor = .white
        container.layer.cornerRadius = 15
        container.layer.shadowColor =  UIColor.color(fromHexString: "EEEEEE").cgColor
        container.layer.shadowOffset = CGSize(width: 1, height: 2)
        container.layer.shadowOpacity = 0.4
        container.layer.shadowRadius = 15
        container.layer.masksToBounds = false
        container.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        container.addSubview(ivAddressPin)
        ivAddressPin.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        let buttonContainer = UIView()
        buttonContainer.backgroundColor = .color(fromHexString: "FAFAFA")
        buttonContainer.layer.cornerRadius = 15
        buttonContainer.layer.masksToBounds = true
        container.addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(34)
        }
        
        buttonContainer.addSubview(ivEdit)
        ivEdit.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().dividedBy(2)
        }
        
        buttonContainer.addSubview(ivDelete)
        ivDelete.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(ivEdit.snp.bottom)
        }
        
        container.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(100)
            make.right.equalToSuperview().inset(50)
        }
        
        container.addSubview(labelDetails)
        labelDetails.snp.makeConstraints { make in
            make.top.equalTo(labelName.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(100)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Address, listener: AddressDelegate) {
        self.listener = listener
        self.address = model
        labelName.text = model.addressName
        labelDetails.text = model.getAddressString()
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func editTapped(_ sender: Any) {
        listener?.addressEditTapped(address: address!)
    }
    
    @objc private func deleteTapped(_ sender: Any) {
        listener?.addressDeleteTapped(address: address!)
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivAddressPin: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_address_card")
        return imageView
    }()
    
    private lazy var ivEdit: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_edit_primary")
        
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(editTapped(_:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private lazy var ivDelete: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_delete_red")
        
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(_:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Home"
        return label
    }()
    
    private let labelDetails: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Kollyanpur, Mizan Tower, 5/3"
        return label
    }()
    
}
