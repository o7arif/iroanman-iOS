//
//  ItemTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/29/21.
//

import UIKit

protocol ItemSelectionDelegate {
    func countUpdated(product: Product, currentCount: Int)
}

class ItemTVCell: UITableViewCell {
    
    static let identifier = "ItemTVCell"
    
    private let container = UIView()
    private let buttonContainer = UIView()
    private var count = 0
    private var product: Product?
    private var listener: ItemSelectionDelegate?
    
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
//        container.layer.shadowColor =  UIColor.color(fromHexString: "EEEEEE").cgColor
//        container.layer.shadowOffset = CGSize(width: 1, height: 2)
//        container.layer.shadowOpacity = 0.4
//        container.layer.shadowRadius = 15
//        container.layer.masksToBounds = false
        container.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        
        container.addSubview(ivItem)
        ivItem.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        
        container.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(110)
            make.right.equalToSuperview().inset(50)
        }
        
        container.addSubview(labelService)
        labelService.snp.makeConstraints { make in
            make.top.equalTo(labelName.snp.bottom).offset(2)
            make.left.equalTo(labelName.snp.left)
            make.right.equalToSuperview().inset(12)
        }
        
        container.addSubview(labelPricePrevious)
        labelPricePrevious.snp.makeConstraints { make in
            make.top.equalTo(labelService.snp.bottom).offset(10)
            make.left.equalTo(labelName.snp.left)
        }
        
        container.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { make in
            make.top.equalTo(labelPricePrevious.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(10)
            make.left.equalTo(labelName.snp.left)
        }
        
        container.addSubview(labelDiscountPercent)
        labelDiscountPercent.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        container.addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10)
            make.height.equalTo(36)
            make.width.equalTo(120)
        }
        
        setupAddItemButton()
    }
    
    private func setupAddItemButton() {
        buttonContainer.addSubview(btnAddItem)
        btnAddItem.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    
    func configure(with model: Product, listener: ItemSelectionDelegate) {
        self.count = model.count
        self.product = model
        self.listener = listener
        ivItem.load(url: URL(string: model.imagePath )!)
        labelName.text = model.name
        labelService.text = model.service.name
        labelPricePrevious.text = "৳" + String(model.oldPrice) + "/item"
        labelPrice.text = "৳" + String(model.currentPrice) + "/item"
        labelDiscountPercent.text = String(model.discountPercentage) + "%"
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func addItemTapped(_ sender: Any) {
        print("add item tapped")
        buttonContainer.removeSubviews()
        setupCounterView()
        
        count = 1
        labelCount.text = ResourceUtil.numberToStringWithZero(number: count)
        listener?.countUpdated(product: product!, currentCount: count)
    }
    
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
            // set add item button
            buttonContainer.removeSubviews()
            setupAddItemButton()
        }
        
        listener?.countUpdated(product: product!, currentCount: count)
    }
    
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivItem: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img_shirt")
        return imageView
    }()
    
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
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .textGrey
        label.text = "Iron Service"
        return label
    }()
    
    private let labelPricePrevious: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textRed
        label.text = "৳15/item"
        return label
    }()
    
    private let labelPrice: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .primary
        label.text = "৳10/item"
        return label
    }()
    
    private let labelDiscountPercent: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textRed
        label.text = "-40%"
        return label
    }()
    
    private lazy var btnAddItem: UIView = {
        let button = UIButton()
        button.setTitle("Add Item", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // click action
        button.addTarget(self, action: #selector(addItemTapped(_:)), for: .touchUpInside)
        return button
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
