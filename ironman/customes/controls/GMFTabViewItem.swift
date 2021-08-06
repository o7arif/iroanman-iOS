//
//  GMFTabViewItem.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/6/21.
//

import UIKit
import MaterialDesignWidgets

class GMFTabViewItem: UIView {
    
    private var onClick: () -> Void = {}
    private var iconImageView = UIImageView()
    private var tabTitle = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(icon: String, title: String, onClick: @escaping () -> ()) {
        self.init(frame: .zero)
        self.onClick = onClick
        iconImageView = UIImageView.init(image: UIImage.init(named: icon))
        iconImageView.contentMode = .center
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        tabTitle.text = title
        tabTitle.font = OpenSans.semiBold.of(size: 10)
        addSubview(tabTitle)
        tabTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(6)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func isTabSelected(isIelected:Bool) {
        if isIelected {
            iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .primary
            tabTitle.textColor = .primary
        } else {
            iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .color(fromHexString: "ic_show_password")
            tabTitle.textColor = .color(fromHexString: "ic_show_password")
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        onClick()
    }
}
