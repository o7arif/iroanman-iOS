//
//  CartItemTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/30/21.
//

import UIKit

protocol CartItemSelectionDelegate {
    func countUpdated(product: Product, currentCount: Int)
}

class CartItemTVCell: UITableViewCell {
    
    static let identifier = "CartItemTVCell"
    
    private let container = UIView()
    private let buttonContainer = UIView()
    private var count = 1
    private var product: Product?
    private var listener: CartItemSelectionDelegate?
    
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
        container.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        container.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(50)
        }
        
        container.addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(120)
        }
        
        container.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(buttonContainer.snp.left).offset(-15)
        }
        
        container.addSubview(labelService)
        labelService.snp.makeConstraints { make in
            make.top.equalTo(labelName.snp.bottom).offset(2)
            make.left.equalTo(labelName.snp.left)
            make.right.equalTo(buttonContainer.snp.left).offset(-15)
            make.bottom.equalToSuperview().inset(10)
        }
        
        setupCounterView()
    }
    
    private func setupCounterView() {
        let counterView = UIView()
        counterView.backgroundColor = .color(fromHexString: "F2F2F2")
        counterView.layer.cornerRadius = 10
        counterView.layer.masksToBounds = true
        buttonContainer.addSubview(counterView)
        counterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        counterView.addSubview(ivMinus)
        ivMinus.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(8)
        }
        
        counterView.addSubview(ivPlus)
        ivPlus.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(8)
        }
        
        counterView.addSubview(labelCount)
        labelCount.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Product, listener: CartItemSelectionDelegate) {
        self.product = model
        self.listener = listener
        self.count = model.count
        labelName.text = model.name
        labelService.text = model.service?.name ?? ""
        let amount = model.currentPrice! * Double(model.count)
        labelPrice.text = ResourceUtil.makeCurrency(amount: amount)
        labelCount.text = ResourceUtil.numberToStringWithZero(number: count)
        
        if count > 1 {
            ivMinus.image = UIImage(named: "ic_minus")
        } else if count == 1 {
            ivMinus.image = UIImage(named: "ic_delete")
        }
        
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func plusTapped(_ sender: Any) {
        print("plus tapped")
        if count == 1 {
            ivMinus.image = UIImage(named: "ic_minus")
        }
        count += 1
        labelCount.text = ResourceUtil.numberToStringWithZero(number: count)
        
        listener?.countUpdated(product: product!, currentCount: count)
    }
    
    @objc private func minusTapped(_ sender: Any) {
        print("minus tapped")
        if count > 2 {
            count -= 1
            labelCount.text = ResourceUtil.numberToStringWithZero(number: count)
        } else if count == 2 {
            count = 1
            labelCount.text = ResourceUtil.numberToStringWithZero(number: count)
            ivMinus.image = UIImage(named: "ic_delete")
        } else if count == 1 {
            count = 0
            // TODO: remove this item feom list
        }
        
        listener?.countUpdated(product: product!, currentCount: count)
    }
    
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Shirt"
        return label
    }()
    
    private let labelService: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textGrey
        label.text = "Iron Service"
        return label
    }()
    
    private let labelPrice: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .primary
        label.text = "৳10.00"
        return label
    }()
    
    private lazy var ivPlus: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_plus")
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(plusTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private let labelCount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "01"
        return label
    }()
    
    private lazy var ivMinus: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_delete")
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(minusTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
}
