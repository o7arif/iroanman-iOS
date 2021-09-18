//
//  OrderStepTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 9/10/21.
//

import UIKit

class OrderStepTVCell: UITableViewCell {
    
    static let identifier = "OrderStepTVCell"
    
    private let container = UIView()
    let line = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(container)
        container.backgroundColor = .white
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let dateTimeContainer = UIView()
        container.addSubview(dateTimeContainer)
        dateTimeContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
            make.width.equalTo(60)
        }
        
        dateTimeContainer.addSubview(labelDate)
        labelDate.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        dateTimeContainer.addSubview(labelTime)
        labelTime.snp.makeConstraints { make in
            make.top.equalTo(labelDate.snp.bottom).offset(2)
            make.left.bottom.right.equalToSuperview()
        }
        
        container.addSubview(ivStatus)
        ivStatus.snp.makeConstraints { make in
            make.left.equalTo(dateTimeContainer.snp.right)
            make.top.equalToSuperview()
            make.height.width.equalTo(20)
        }
        
        line.backgroundColor = .primary
        container.addSubview(line)
        line.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.top.equalToSuperview().inset(16)
            make.centerX.equalTo(ivStatus)
            make.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(30)
        }
        container.sendSubviewToBack(line)
        
        container.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.left.equalTo(ivStatus.snp.right).offset(20)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    
    
    // MARK: SETUP DATA
    
    func configure(with model: OrderStep, isLastStep: Bool, isLastCompletedStep: Bool) {
        labelDate.text = model.date
        labelTime.text = model.time
        labelName.text = model.name
        
        if model.isCompleted {
            ivStatus.image = UIImage(named: "ic_complete")
            if isLastCompletedStep {
                line.backgroundColor = .color(fromHexString: "93A0B2")
            } else {
                line.backgroundColor = .primary
            }
        } else {
            ivStatus.image = UIImage(named: "ic_incomplete")
            line.backgroundColor = .color(fromHexString: "93A0B2")
        }
        
        if isLastStep {
            line.isHidden = true
        } else {
            line.isHidden = false
        }
        
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "ic_incomplete")
        return imageView
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = ""
        return label
    }()
    
    private let labelTime: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = ""
        return label
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = ""
        return label
    }()
    
}
