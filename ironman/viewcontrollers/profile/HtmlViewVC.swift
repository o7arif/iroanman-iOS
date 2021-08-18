//
//  HtmlViewVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/19/21.
//

import UIKit
import WebKit

enum HtmlType: String {
    case PRIVACY_POLICY = "Privacy Policy"
    case TERMS_OF_SERVICE = "Terms of Service"
}

class HtmlViewVC: BaseVC {
    
    var htmlType: HtmlType?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        viewSetup()
        setupViews()
        setData()
    }
    
    private func setupViews() {
        container.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        viewHeaderBack.addSubview(ivBack)
        ivBack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
        }
        
        labelHeaderTitle.text = htmlType?.rawValue ?? ""
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.right.equalToSuperview()
        }
        
        container.addSubview(webView)
        webView.backgroundColor = .clear
        webView.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        
        container.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(AppConst.buttonHeight)
        }
    }
    
    
    // MARK: SETUP DATA
    
    private func setData() {
        let html = FakeDataHelper.getHtmlData(htmlType: htmlType)
        webView.loadHTMLString(html, baseURL: nil)
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
        label.text = ""
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
