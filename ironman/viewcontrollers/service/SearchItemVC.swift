//
//  SearchItemVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/30/21.
//

import UIKit

protocol SearchItemDelegate {
    func onSearchItemChanges(products: [Product])
}

class SearchItemVC: BaseVC {
    
    private var searchKey: String = ""
    
    private var completeProducts = [Product]()
    private var products = [Product]()
    private var listener: SearchItemDelegate?
    
    func configure(with products: [Product], listener: SearchItemDelegate) {
        self.completeProducts = products
        self.products = products
        self.listener = listener
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.backgroundColor = .color(fromHexString: "FAFAFA")
        
        setupViews()
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
        
        let searchContainer = UIView()
        searchContainer.backgroundColor = .white.withAlphaComponent(0.10)
        searchContainer.layer.cornerRadius = 10
        searchContainer.layer.masksToBounds = true
        viewHeaderBack.addSubview(searchContainer)
        searchContainer.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.equalToSuperview().inset(75)
        }
        
        searchContainer.addSubview(ivSearch)
        ivSearch.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        searchContainer.addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        container.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemTVCell.self, forCellReuseIdentifier: ItemTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        listener?.onSearchItemChanges(products: completeProducts)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: SEARCH TEXT CHANGING EVENT
    
    @objc private func onSearchTextChanged(_ sender: Any) {
        print("search keyword: \(searchField.text ?? "")")
        searchKey = searchField.text ?? ""
        
        products.removeAll()
        if searchKey.isEmpty {
            products = completeProducts
        } else {
            products = completeProducts.filter { $0.name.lowercased().contains(searchKey.lowercased()) }
        }
        tableView.reloadData()
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
        return view
    }()
    
    private let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search items"
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.keyboardType = .default
        textField.returnKeyType = .search
        textField.autocorrectionType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = OpenSans.regular.of(size: AppConst.fontSize14)
        textField.clearButtonMode = .never
        textField.contentVerticalAlignment = .center
        textField.addTarget(self, action: #selector(onSearchTextChanged(_:)), for: UIControl.Event.editingChanged)
        
        return textField
    }()
    
    private lazy var ivSearch: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_search")
        imageView.contentMode = .scaleAspectFit
        return imageView
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


extension SearchItemVC: UITableViewDelegate, UITableViewDataSource, ItemSelectionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTVCell.identifier) as! ItemTVCell
        cell.configure(with: products[indexPath.row], listener: self)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func countUpdated(product: Product, currentCount: Int) {
        if let row = self.products.firstIndex(where: {$0.id == product.id}) {
            products[row].count = currentCount
        }
        
        if let row = self.completeProducts.firstIndex(where: {$0.id == product.id}) {
            completeProducts[row].count = currentCount
        }
    }
    
}
