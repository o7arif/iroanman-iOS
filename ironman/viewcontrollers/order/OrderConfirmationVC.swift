//
//  OrderConfirmationVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import UIKit

class OrderConfirmationVC: BaseVC {
    
    private let wrapperView = UIView()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.addSubview(wrapperView)
        wrapperView.backgroundColor = .white
        wrapperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapperView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(173)
        }
        
        wrapperView.addSubview(labelConfirmed)
        labelConfirmed.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).offset(26)
        }
        
        wrapperView.addSubview(labelOrderNo)
        labelOrderNo.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelConfirmed.snp.bottom).offset(20)
        }
        
        wrapperView.addSubview(btnSeeMyOrder)
        btnSeeMyOrder.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(88)
            make.height.equalTo(50)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func seeMyOrderTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_order_confirmed")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelConfirmed: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Your order has been Confirmed"
        return label
    }()
    
    private let labelOrderNo: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .primary
        label.text = "Your Order ID #123456"
        return label
    }()
    
    private let btnSeeMyOrder: UIView = {
        let button = UIButton()
        button.setTitle("See My Order", for: .normal)
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
        button.addTarget(self, action: #selector(seeMyOrderTapped(_:)), for: .touchUpInside)
        return button
    }()
    
}
