//
//  OrderTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/21/21.
//

import UIKit

class OrderTVCell: UITableViewCell {
    
    static let identifier = "OrderTVCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .backgroundColor
        self.contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        cardView.addSubview(labelOrderId)
        labelOrderId.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(12)
        }
        
        cardView.addSubview(labelAmount)
        labelAmount.snp.makeConstraints { make in
            make.top.equalTo(labelOrderId.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
        }
        
        cardView.addSubview(labelDeliveryMethod)
        labelDeliveryMethod.snp.makeConstraints { make in
            make.top.equalTo(labelAmount.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
        
    }
    
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Order) {
        
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let labelOrderId: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Order ID #123456"
        return label
    }()
    
    private let labelAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Amount: ৳70.00"
        return label
    }()
    
    private let labelDeliveryMethod: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Cash on Delivery"
        return label
    }()
    
}
