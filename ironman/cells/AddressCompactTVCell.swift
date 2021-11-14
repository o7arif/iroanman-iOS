//
//  AddressCompactTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/14/21.
//

import UIKit

class AddressCompactTVCell: UITableViewCell {
    
    static let identifier = "AddressCompactTVCell"
    
    private let container = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
    
        self.contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Address) {
        labelName.text = model.addressName
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = ""
        return label
    }()
    
}
