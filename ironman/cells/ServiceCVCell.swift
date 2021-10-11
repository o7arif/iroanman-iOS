//
//  ServiceCVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/15/21.
//

import UIKit

class ServiceCVCell: UICollectionViewCell {
    
    static let identifier = "ServiceCVCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cardView.addSubview(ivService)
        ivService.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(80)
        }
        
        cardView.addSubview(labelService)
        labelService.snp.makeConstraints { make in
            make.top.equalTo(ivService.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(btnGetService)
        btnGetService.snp.makeConstraints { make in
            make.top.equalTo(labelService.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Category) {
        // uncomment later
//        labelService.text = model.name
//        ivService.load(url: URL(string: model.imagePath ?? "")!)
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor.color(fromHexString: "D5D7D8").cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    private let ivService: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_service_emergency")
        return imageView
    }()
    
    private let labelService: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 12)
        label.numberOfLines = 0
        label.text = "Emergency Service"
        label.textAlignment = .center
        label.textColor = .textBlack
        return label
    }()
    
    private let btnGetService: UIView = {
        let button = UIButton()
        button.setTitle("Get Service", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 8)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(getServiceTapped), for: .touchUpInside)
        return button
    }()
}


// MARK: TAP ACTIONS

extension ServiceCVCell {
    
    @objc private func getServiceTapped() {
        print("Get Service Tapped")
    }
    
}
