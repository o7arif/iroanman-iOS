//
//  ManageAddress.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

class ManageAddressVC: BaseVC {
    
    private let authRequiredContainer = UIView()
    
    private var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.backgroundColor = .backgroundColor
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAddresses()
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
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.right.equalToSuperview()
        }
        
        container.addSubview(btnAddAddress)
        btnAddAddress.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
        container.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AddressTVCell.self, forCellReuseIdentifier: AddressTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(btnAddAddress.snp.top)
        }
        
//        authentionRequiredMessage()
//        emptyListMessage()
    }
    
    
    private func authentionRequiredMessage() {
        // not logged in so user are not allowed to add new address
        btnAddAddress.isHidden = true
        
        container.addSubview(authRequiredContainer)
        authRequiredContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(46)
        }
        
        authRequiredContainer.addSubview(ivAddress)
        ivAddress.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        authRequiredContainer.addSubview(labelNotAuthenticated)
        labelNotAuthenticated.snp.makeConstraints { make in
            make.top.equalTo(ivAddress.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
        container.addSubview(btnSignIn)
        btnSignIn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func emptyListMessage() {
        
        btnAddAddress.isHidden = false
        btnSignIn.removeFromSuperview()
        authRequiredContainer.removeFromSuperview()
        
        let emptyContainer = UIView()
        container.addSubview(emptyContainer)
        emptyContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(46)
        }
        
        emptyContainer.addSubview(ivAddress)
        ivAddress.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        emptyContainer.addSubview(labelEmptyList)
        labelEmptyList.snp.makeConstraints { make in
            make.top.equalTo(ivAddress.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func signInTapped(_ sender: Any) {
        print("sign in tapped")
    }
    
    @objc private func addNewAddressTapped(_ sender: Any) {
        self.navigationController?.pushViewController(NewAddressVC(), animated: true)
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
        label.text = "Manage Address"
        return label
    }()
    
    private let ivAddress: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_address")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelNotAuthenticated: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "You are not signed in!\nPlease sign in first."
        return label
    }()
    
    private let labelEmptyList: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "You address list is empty!"
        return label
    }()
    
    private let btnSignIn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
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
        button.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let btnAddAddress: UIButton = {
        let button = UIButton()
        button.setTitle("Add New Address", for: .normal)
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
        button.addTarget(self, action: #selector(addNewAddressTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
}




extension ManageAddressVC: UITableViewDelegate, UITableViewDataSource, AddressDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTVCell.identifier) as! AddressTVCell
        cell.selectionStyle = .none
        cell.configure(with: addresses[indexPath.row], listener: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func addressEditTapped(address: Address) {
        let vc = NewAddressVC()
        vc.address = address
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addressDeleteTapped(address: Address) {
        print("address delete tapped")
    }
    

}




// MARK: API CALLING

extension ManageAddressVC {
    
    private func fetchAddresses() {
        
        addresses.removeAll()
        
        Networking.instance.call(api: "addresses", method: .get, parameters: [:]) { (responseModel) in
            if responseModel.code == 200 {
                guard let dataDictionary = responseModel.body["data"] as? Dictionary<String, Any> else {
                    return
                }
                
                guard let dictionary = dataDictionary["addresses"] as? Array<Dictionary<String, Any>> else {
                    return
                }
                
                for i in 0..<dictionary.count {
                    let address = Address.init(fromDictionary: dictionary[i])
                    self.addresses.append(address)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.tableView.reloadData()
            }
        }
        
    }
    
}
