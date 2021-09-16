//
//  DatePickerView.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 9/17/21.
//

import UIKit

class DatePickerView: UIView {
    
    var date = "" {
        didSet {
            labelDate.text = date
        }
    }
    
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        
        self.addSubview(container)
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(ivCalendar)
        ivCalendar.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(10)
        }
        
        container.addSubview(labelDate)
        labelDate.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivCalendar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_calendar")
        return imageView
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .primary
        label.text = ""
        return label
    }()
}
