//
//  AddressDialogVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/14/21.
//

import UIKit

protocol AddressDialogDelegate {
    func newAddressTapped()
    func addressTapped(address: Address)
}

class AddressDialogVC: UIViewController {
    
    var listener: AddressDialogDelegate?
    
    private var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchAddresses()
    }
    
    private func setupViews() {
        
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
        }
        
        container.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AddressCompactTVCell.self, forCellReuseIdentifier: AddressCompactTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        container.addSubview(viewAddAddress)
        viewAddAddress.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        viewAddAddress.addSubview(viewLine)
        viewLine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        viewAddAddress.addSubview(ivPlus)
        ivPlus.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
            make.height.width.equalTo(24)
        }
        
        viewAddAddress.addSubview(labelAddNewAddress)
        labelAddNewAddress.snp.makeConstraints { make in
            make.centerY.equalTo(ivPlus)
            make.left.equalTo(ivPlus.snp.right).offset(16)
            make.right.equalToSuperview()
        }
        
        
    }
    
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func addNewAddressTapped(_ sender: Any) {
        listener?.newAddressTapped()
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.primary.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = .borderColor
        return view
    }()
    
    private lazy var viewAddAddress: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        // tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(addNewAddressTapped(_:)))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private let ivPlus: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_plus")?.withTintColor(.primary)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelAddNewAddress: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .primary
        label.text = "Add new Address"
        return label
    }()
}




extension AddressDialogVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCompactTVCell.identifier) as! AddressCompactTVCell
        cell.selectionStyle = .none
        cell.configure(with: addresses[indexPath.row])
        
        print("height: \(cell.bounds.height)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.addressTapped(address: addresses[indexPath.row])
    }
    

}




// MARK: API CALLING

extension AddressDialogVC {
    
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
                    self.updateTVHeight()
                    self.tableView.reloadData()
                }
            } else {
                self.updateTVHeight()
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    private func updateTVHeight() {
        tableView.snp.updateConstraints { make in
            make.height.equalTo(addresses.count * 44)
        }
    }
    
}
