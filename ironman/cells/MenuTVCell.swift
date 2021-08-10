//
//  MenuTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/11/21.
//

import UIKit

class MenuTVCell: UITableViewCell {
    
    static let identifier = "MenuTVCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .white
        let label = UILabel()
        label.text = "Menu"
        label.textColor = .textBlack
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
