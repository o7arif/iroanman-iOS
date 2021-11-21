//
//  OnGoingOrderSegmentVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

class OnGoingOrderSegmentVC: UIViewController {
    
    private let container = UIView()
    private var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(container)
        container.backgroundColor = .backgroundColor
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        emptyListMessage()
        setupOngoingOrderView()
    }
    
    
    
    // MARK: EMPTY ORDER LIST
    
    private func emptyListMessage() {
        let emptyListContainer = UIView()
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
    
    
    // MARK: ONGOING ORDER VIEW
    
    private func setupOngoingOrderView() {
        
        container.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTVCell.self, forCellReuseIdentifier: OrderTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        
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
        label.text = "Your order list is Empty."
        return label
    }()
    
    
    // ongoing order
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
}




extension OnGoingOrderSegmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTVCell.identifier) as! OrderTVCell
        //        cell.configure(with: orders[indexPath.section])
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
    
}
