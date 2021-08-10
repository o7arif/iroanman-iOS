//
//  MenuTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/11/21.
//

import UIKit

class MenuTVCell: UITableViewCell {
    
    static let identifier = "MenuTVCell"
    
    private let container = UIView()
    private let lvPlain = LineView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .white
       
        self.contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(ivIcon)
        ivIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        }
        
        container.addSubview(ivArrow)
        ivArrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
        }
        
        container.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(ivIcon.snp.right).offset(15)
        }
        
        container.addSubview(lvPlain)
        lvPlain.config.lineType = .PLAIN
        lvPlain.config.color = .color(fromHexString: "F2F2F2")
        lvPlain.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    

    // MARK: CONFIGURE UI
    func configure(with model: Menu) {
        labelName.text = model.name
        ivIcon.image = model.icon
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
    
    private let ivIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_menu_address")
        return imageView
    }()
    
    private let ivArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_menu_arrow")
        return imageView
    }()
    
    
}
