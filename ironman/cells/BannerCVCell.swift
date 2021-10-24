//
//  PromotionCVCell.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/15/21.
//

import UIKit

class BannerCVCell: UICollectionViewCell {
    
    static let identifier = "BannerCVCell"
    
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        container.addSubview(ivPromotion)
        ivPromotion.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: SETUP DATA
    
    func configure(with model: Banner) {
        // will uncomment later
        ivPromotion.load(url: URL(string: model.imagePath ?? "")!)
    }
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let ivPromotion: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = false
        imageView.image = UIImage(named: "img_promotion")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.color(fromHexString: "D5D7D8").cgColor
        imageView.layer.shadowOffset = CGSize(width: 1, height: 4)
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowRadius = 15
        return imageView
    }()
}
