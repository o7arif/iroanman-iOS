//
//  OnGoingOrderSegmentVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

class OnGoingOrderSegmentVC: UIViewController {
    
    private let container = UIView()
    private let lvDash = LineView()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(container)
        container.backgroundColor = .color(fromHexString: "F2F2F2")
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
        container.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(30)
        }
        
        cardView.addSubview(labelOrderId)
        labelOrderId.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(20)
        }
        
        cardView.addSubview(labelAmount)
        labelAmount.snp.makeConstraints { make in
            make.top.equalTo(labelOrderId.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
        }
        
        cardView.addSubview(labelDeliveryMethod)
        labelDeliveryMethod.snp.makeConstraints { make in
            make.top.equalTo(labelAmount.snp.bottom)
            make.left.equalToSuperview().inset(20)
        }
        
        cardView.addSubview(lvDash)
        lvDash.config.color = .color(fromHexString: "F2F2F2")
        lvDash.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(labelDeliveryMethod.snp.bottom).offset(20)
        }
        
        cardView.addSubview(viewBallLeft)
        viewBallLeft.snp.makeConstraints { make in
            make.centerY.equalTo(lvDash.snp.bottom)
            make.centerX.equalTo(cardView.snp.left)
            make.height.width.equalTo(20)
        }
        
        cardView.addSubview(viewBallRight)
        viewBallRight.snp.makeConstraints { make in
            make.centerY.equalTo(lvDash.snp.bottom)
            make.centerX.equalTo(cardView.snp.right)
            make.height.width.equalTo(20)
        }
        
        cardView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderStepTVCell.self, forCellReuseIdentifier: OrderStepTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewBallLeft.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(300)
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
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
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
    
    private let labelOrderId: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Order ID #123456"
        return label
    }()
    
    private let labelAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Amount: ৳70.00"
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
    
    private let labelDeliveryMethod: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Cash on Delivery"
        return label
    }()

    
}




extension OnGoingOrderSegmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderStepTVCell.identifier) as! OrderStepTVCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
