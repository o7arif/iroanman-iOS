//
//  ProfileVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/6/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let wrapperView = UIView()
    private let lvDash = LineView()
    
    private var menus: [Menu] = MenuHelper.getMenus()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.addSubview(wrapperView)
        wrapperView.backgroundColor = .color(fromHexString: "EFEFEF")
        wrapperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapperView.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        self.view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(viewHeaderBack.snp.bottom).inset(80)
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(ivProfile)
        ivProfile.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(cardView.snp.top)
            make.height.width.equalTo(100)
        }
        
        cardView.addSubview(labelLogin)
        labelLogin.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(13)
            make.top.equalToSuperview().inset(21)
        }
        
        cardView.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelLogin.snp.bottom).offset(30)
        }
        
        cardView.addSubview(labelAddress)
        labelAddress.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelName.snp.bottom).offset(5)
        }
        
        cardView.addSubview(lvDash)
        lvDash.config.color = .color(fromHexString: "F2F2F2")
        lvDash.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelAddress.snp.bottom).offset(10)
        }
        
        cardView.addSubview(viewBallLeft)
        viewBallLeft.snp.makeConstraints { make in
            make.top.equalTo(lvDash.snp.bottom)
            make.centerX.equalTo(cardView.snp.left)
            make.height.width.equalTo(20)
        }
        
        cardView.addSubview(viewBallRight)
        viewBallRight.snp.makeConstraints { make in
            make.top.equalTo(lvDash.snp.bottom)
            make.centerX.equalTo(cardView.snp.right)
            make.height.width.equalTo(20)
        }
        
        cardView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuTVCell.self, forCellReuseIdentifier: MenuTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewBallLeft.snp.bottom).offset(45)
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func loginTapped(_ sender: Any) {
        print("Login tapped")
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let viewHeaderBack: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.semiBold.of(size: 20) // this sould be poppins semi bold
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Profile"
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let ivProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_profile")
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.color(fromHexString: "F2F2F2").cgColor
        imageView.layer.backgroundColor = UIColor.color(fromHexString: "F2F2F2").cgColor
        imageView.layer.shadowColor = UIColor.color(fromHexString: "555555").cgColor
        imageView.layer.shadowOffset = CGSize(width: 1, height: 2)
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowRadius = 20
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .color(fromHexString: "00C2CB")
        label.text = "Login"
        
        // click actions
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapped(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Unknown"
        return label
    }()
    
    private let labelAddress: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textGrey
        label.text = "Unknown address"
        return label
    }()
    
    private let viewBallLeft: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .color(fromHexString: "EFEFEF")
       return view
    }()
    
    private let viewBallRight: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .color(fromHexString: "EFEFEF")
       return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
}


extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTVCell.identifier) as! MenuTVCell
        cell.selectionStyle = .none
        cell.configure(with: menus[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleTableItemClick(menus[indexPath.row])
    }
    
    private func handleTableItemClick(_ menu: Menu) {
        switch menu.name {
        case MenuEnum.MANAGE_ADDRESS.rawValue:
            self.navigationController?.pushViewController(ManageAddressVC(), animated: true)
            break
        case MenuEnum.PRIVACY_POLICY.rawValue:
            print("\(menu.name) clicked")
            break
        case MenuEnum.TERMS_OF_SERVICE.rawValue:
            print("\(menu.name) clicked")
            break
        case MenuEnum.CONTACT.rawValue:
            print("\(menu.name) clicked")
            break
        case MenuEnum.ABOUT.rawValue:
            print("\(menu.name) clicked")
            break
        default:
            print("default clicked")
            break
        }
    }
}
