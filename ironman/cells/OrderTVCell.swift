//
//  OrderTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/21/21.
//

import UIKit

class OrderTVCell: UITableViewCell {
    
    static let identifier = "OrderTVCell"
    
    private var order: Order?
    private var listener: OrderDelegate?
    
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
        
        cardView.addSubview(btnFeedback)
        btnFeedback.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(130)
        }
        
    }
    
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Order, isCompleted: Bool, _ listener: OrderDelegate? = nil) {
        
        self.order = model
        self.listener = listener
        
        if isCompleted {
            btnFeedback.isHidden = false
        } else {
            btnFeedback.isHidden = true
        }
        
        labelOrderId.text = "Order ID #\(model.id)"
        labelAmount.text = "Amount: " + ResourceUtil.makeCurrency(amount: model.amount)
    }
    
    
    
    
    
    // MARK: TAP ACTIONS
    
    @objc private func feedbackTapped(_ sender: Any) {
        listener?.onFeedbackTapped(order: order!)
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
        label.text = ""
        return label
    }()
    
    private let labelAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = ""
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
    
    private let btnFeedback: UIButton = {
        let button = UIButton()
        button.setTitle("Feedback", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(feedbackTapped(_:)), for: .touchUpInside)
        return button
    }()
    
}
