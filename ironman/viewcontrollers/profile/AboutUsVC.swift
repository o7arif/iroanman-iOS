//
//  AboutUsVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/16/21.
//

import UIKit

class AboutUsVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        container.backgroundColor = .color(fromHexString: "FAFAFA")
        container.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        viewHeaderBack.addSubview(ivBack)
        ivBack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.right.equalToSuperview()
        }
        
        viewHeaderBack.addSubview(ivLogo)
        ivLogo.snp.makeConstraints { make in
            make.top.equalTo(ivBack.snp.bottom).offset(31)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(27)
        }
        
        // who we are
        container.addSubview(labelWhoTitle)
        labelWhoTitle.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(labelWho)
        labelWho.snp.makeConstraints { make in
            make.top.equalTo(labelWhoTitle.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // what we do
        container.addSubview(labelWhatTitle)
        labelWhatTitle.snp.makeConstraints { make in
            make.top.equalTo(labelWho.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(labelWhat)
        labelWhat.snp.makeConstraints { make in
            make.top.equalTo(labelWhatTitle.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // how we work
        container.addSubview(labelHowTitle)
        labelHowTitle.snp.makeConstraints { make in
            make.top.equalTo(labelWhat.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(ivHow1)
        ivHow1.snp.makeConstraints { make in
            make.top.equalTo(labelHowTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
        }
        
        container.addSubview(labelHow1)
        labelHow1.snp.makeConstraints { make in
            make.top.equalTo(ivHow1.snp.top).offset(2)
            make.left.equalTo(ivHow1.snp.right).offset(10)
            make.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(ivHow2)
        ivHow2.snp.makeConstraints { make in
            make.top.equalTo(ivHow1.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
        }
        
        container.addSubview(labelHow2)
        labelHow2.snp.makeConstraints { make in
            make.top.equalTo(ivHow2.snp.top).offset(2)
            make.left.equalTo(ivHow2.snp.right).offset(10)
            make.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(ivHow3)
        ivHow3.snp.makeConstraints { make in
            make.top.equalTo(ivHow2.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
        }
        
        container.addSubview(labelHow3)
        labelHow3.snp.makeConstraints { make in
            make.top.equalTo(ivHow3.snp.top).offset(2)
            make.left.equalTo(ivHow3.snp.right).offset(10)
            make.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(AppConst.buttonHeight)
        }
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivBack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_back")
        imageView.contentMode = .scaleAspectFit
        
        // click action
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTapped(_:)))
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
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
        label.text = "About Us"
        return label
    }()
    
    private let ivLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelWhoTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackDark
        label.text = "Who we are?"
        return label
    }()
    
    private let labelWho: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackLight
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        return label
    }()
    
    private let labelWhatTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackDark
        label.text = "What we do?"
        return label
    }()
    
    private let labelWhat: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackLight
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        return label
    }()
    
    private let labelHowTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackDark
        label.text = "How we work?"
        return label
    }()
    
    private let ivHow1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_no_1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ivHow2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_no_2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ivHow3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_no_3")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelHow1: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackLight
        label.text = "We pickup your clothes"
        return label
    }()
    
    private let labelHow2: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackLight
        label.text = "We clean your clothes"
        return label
    }()
    
    private let labelHow3: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textBlackLight
        label.text = "We deliver clean and folded clothes"
        return label
    }()
    
    
    private let btnClose: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
        return button
    }()
}
