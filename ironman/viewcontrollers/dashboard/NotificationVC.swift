//
//  NotificationVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/27/21.
//

import UIKit

class NotificationVC: UIViewController {
    private let container = UIView()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(container)
        container.backgroundColor = .color(fromHexString: "FAFAFA")
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview()
        }
        
        emptyNotificationMessage()
    }
    
    
    private func emptyNotificationMessage() {
        let emptyNotificationContainer = UIView()
        container.addSubview(emptyNotificationContainer)
        emptyNotificationContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(46)
        }
        
        emptyNotificationContainer.addSubview(ivNotification)
        ivNotification.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        emptyNotificationContainer.addSubview(labelEmptyNotification)
        labelEmptyNotification.snp.makeConstraints { make in
            make.top.equalTo(ivNotification.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let viewHeaderBack: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.semiBold.of(size: 20)     // should be Poppins Semibold 20
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = L10n.Label.notifications
        return label
    }()
    
    private let ivNotification: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_notification")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelEmptyNotification: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = L10n.Label.yourNotificationIsEmpty
        return label
    }()
}
