//
//  CompletedOrderSegmentVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

class CompletedOrderSegmentVC: UIViewController {
    
    private let container = UIView()
    private let lvDash = LineView()
    private let orderSteps = FakeDataHelper.getCompletedOrderSteps()
    
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
        setupCompletedOrderView()
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
    
    
    // MARK: COMPLETED ORDER VIEW
    
    private func setupCompletedOrderView() {
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
        
        
        
        cardView.addSubview(btnFeedback)
        btnFeedback.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(36)
            make.width.equalTo(130)
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
        label.text = "Your order list is Empty."
        return label
    }()
    
    
    // completed order
    
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
    
    private let btnFeedback: UIButton = {
        let button = UIButton()
        button.setTitle("Feedback", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(feedbackTapped(_:)), for: .touchUpInside)
        return button
    }()

    
}




extension CompletedOrderSegmentVC: UITableViewDelegate, UITableViewDataSource {
    
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
