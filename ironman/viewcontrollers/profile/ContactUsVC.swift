//
//  ContactUsVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/15/21.
//

import UIKit

class ContactUsVC: BaseVC {
    
    private var tvMessage = NotesTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.right.equalToSuperview()
        }
        
        container.addSubview(ivImg)
        ivImg.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        container.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalTo(ivImg.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        cardView.addSubview(ivPin)
        ivPin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        
        cardView.addSubview(labelAddress)
        labelAddress.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(ivPin.snp.bottom).offset(15)
        }
        
        cardView.addSubview(ivCall)
        ivCall.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelAddress.snp.bottom).offset(37)
        }
        
        cardView.addSubview(labelContactNo)
        labelContactNo.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(ivCall.snp.bottom).offset(15)
        }
        
        // message
        tvMessage.placeholder = "Write a message"
        cardView.addSubview(tvMessage)
        tvMessage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelContactNo.snp.bottom).offset(37)
            make.height.equalTo(90)
        }
        
        cardView.addSubview(btnSend)
        btnSend.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(tvMessage.snp.bottom).offset(15)
            make.height.equalTo(36)
            make.width.equalTo(120)
        }
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendTapped(_ sender: Any) {
        print("send tapped")
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
        label.text = "Contact Us"
        return label
    }()
    
    private lazy var ivImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_contact_us")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var ivPin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_pin")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelAddress: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "9/2 Ring Road, Shamoly , Dhaka-1207 Bangladesh"
        return label
    }()
    
    private lazy var ivCall: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_call")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelContactNo: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "+880 1689 37 19 47\n+880 1703 99 89 03"
        return label
    }()
    
    private let btnSend: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(sendTapped(_:)), for: .touchUpInside)
        return button
    }()
}
