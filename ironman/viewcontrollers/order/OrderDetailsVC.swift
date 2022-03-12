//
//  OrderDetailsVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/22/21.
//

import UIKit

class OrderDetailsVC: UIViewController {
    
    var isCompleted: Bool = false
    var order: Order?
    
    private let container = UIView()
    private let lvDash = LineView()
    private let orderSteps = FakeDataHelper.getOngoingOrderSteps()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.addSubview(container)
        container.backgroundColor = .backgroundColor
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
        container.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(30)
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
    
    
    
    // MARK: TAP ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
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
        label.text = L10n.Label.orderDetails
        return label
    }()
    
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
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    private let viewBallRight: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    private let labelDeliveryMethod: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = L10n.Label.cashOnDelivery
        return label
    }()
    
    
}




extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderStepTVCell.identifier) as! OrderStepTVCell
        cell.selectionStyle = .none
        
        var nextStep: OrderStep?
        
        let nextIndex = indexPath.row + 1
        if nextIndex < orderSteps.count {
            nextStep = orderSteps[nextIndex]
        }
        
        let currentStep = orderSteps[indexPath.row]
        
        var isLastCompletedStep = false
        if currentStep.isCompleted {
            if nextStep?.isCompleted == false {
                isLastCompletedStep = true
            }
        }
        
        cell.configure(with: currentStep, isLastStep: nextStep == nil, isLastCompletedStep: isLastCompletedStep)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
