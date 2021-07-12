//
//  WelcomeCVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/12/21.
//

import UIKit

class WelcomeCVCell: UICollectionViewCell {
    
    static let identifier = "WelcomeCVCell"
    
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(container)
        container.backgroundColor = .yellow
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.height.equalTo(200)
        }
    }
}
