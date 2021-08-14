//
//  AddressTVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import UIKit

class AddressTVCell: UITableViewCell {
    
    static let identifier = "AddressTVCell"
    
    private let container = UIView()
    
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
        
        self.textLabel?.text = "Address"
        self.textLabel?.textColor = .blue
    }
    
}
