//
//  CompletedOrderSegmentVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

class CompletedOrderSegmentVC: UIViewController {
    
    var listener: OrderDelegate?
    
    private let container = UIView()
    private let emptyListContainer = UIView()
    private var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCompletedOrders()
    }
    
    private func setupViews() {
        self.view.addSubview(container)
        container.backgroundColor = .backgroundColor
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTVCell.self, forCellReuseIdentifier: OrderTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    
    
    // MARK: EMPTY ORDER LIST
    
    private func emptyListMessage() {
        container.addSubview(emptyListContainer)
        emptyListContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(46)
        }
        
        emptyListContainer.addSubview(ivBox)
        ivBox.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        emptyListContainer.addSubview(labelEmptyOderList)
        labelEmptyOderList.snp.makeConstraints { make in
            make.top.equalTo(ivBox.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func feedbackTapped(_ sender: Any) {
        self.present(OrderFeedbackVC(), animated: true, completion: nil)
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let ivBox: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_cart_box")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelEmptyOderList: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = L10n.Message.yourOrderListIsEmpty
        return label
    }()
    
    
    // completed order
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
}




// MARK: TABLE VIEW CONFIGURATION

extension CompletedOrderSegmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTVCell.identifier) as! OrderTVCell
        cell.configure(with: orders[indexPath.section], isCompleted: true, listener)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        listener?.onOrderTapped(isCompleted: true, order: orders[indexPath.section])
    //    }
    
}





// MARK: API CALLING

extension CompletedOrderSegmentVC {
    
    private func fetchCompletedOrders() {
        
        orders.removeAll()
        
        let params = [
            "status": "completed"
        ] as [String: Any]
        
        Networking.instance.call(api: "orders", method: .get, parameters: params) { (responseModel) in
            if responseModel.code == 200 {
                if let dataDictionary = responseModel.body["data"] as? Dictionary<String, Any> {
                    if let dictionary = dataDictionary["orders"] as? Array<Dictionary<String, Any>> {
                        
                        for i in 0..<dictionary.count {
                            let order = Order.init(fromDictionary: dictionary[i])
                            self.orders.append(order)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        self.tableView.reloadData()
                    }
                } else {
                    self.tableView.reloadData()
                }
                
                if self.orders.count == 0 {
                    self.emptyListMessage()
                } else {
                    self.emptyListContainer.removeFromSuperview()
                }
            }
            
        }
        
    }
    
}
