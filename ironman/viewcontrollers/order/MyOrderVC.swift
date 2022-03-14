//
//  MyOrderVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

protocol OrderDelegate {
    func onOrderTapped(isCompleted: Bool, order: Order)
    func onFeedbackTapped(order: Order)
}

class MyOrderVC: UIViewController {
    
    private let container = UIView()
    private let segmentContainer = UIView()
    private let segmentControl: LegacySegmentedControl = LegacySegmentedControl()
    
    // segment VCs
    private let ongoingVC = OnGoingOrderSegmentVC()
    private let completedVC = CompletedOrderSegmentVC()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(container)
        container.backgroundColor = .color(fromHexString: "FAFAFA")
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(viewHeaderBack)
        viewHeaderBack.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview()
        }
        
        setupSegmentControl()
    }
    
    
    
    // MARK: SEGMENT CONTROL
    
    private func setupSegmentControl() {
        segmentControl.removeAllSegments()
        
        segmentControl.insertSegment(withTitle: L10n.Label.onGoing, at: 0, animated: false)
        segmentControl.insertSegment(withTitle: L10n.Label.completed, at: 1, animated: false)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColorDidChange()
        
        segmentControl.layer.shadowColor = UIColor.color(fromHexString: "AAAAAA", alpha: 15.0).cgColor
        segmentControl.layer.shadowOffset = CGSize(width: 1, height: 2)
        segmentControl.layer.shadowOpacity = 0.4
        segmentControl.layer.shadowRadius = 25
        
        container.addSubview(segmentControl)
        segmentControl.addTarget(self, action: #selector(segmentedControlValueDidChange(_:)), for: .valueChanged)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        container.addSubview(segmentContainer)
        segmentContainer.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
//        addChild(ongoingVC)
//        addChild(completedVC)
        
        ongoingVC.listener = self
        segmentContainer.addSubview(ongoingVC.view)
        ongoingVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        completedVC.listener = self
        segmentContainer.addSubview(completedVC.view)
        completedVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        ongoingVC.didMove(toParent: self)
//        completedVC.didMove(toParent: self)
        
        segmentVisibility(index: 0)
    }
    
    @objc private func segmentedControlValueDidChange(_ segment: UISegmentedControl) {
        segmentVisibility(index: segment.selectedSegmentIndex)
    }
    
    private func segmentVisibility(index: Int) {
        switch index {
        case 0:
            ongoingVC.view.isHidden = false
            completedVC.view.isHidden = true
        case 1:
            ongoingVC.view.isHidden = true
            completedVC.view.isHidden = false
        default:
            ongoingVC.view.isHidden = false
            completedVC.view.isHidden = true
        }
    }
    
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let viewHeaderBack: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.clipsToBounds = true
        return view
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.semiBold.of(size: 20)     // should be Poppins Semibold 20
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = L10n.Label.myOrder
        return label
    }()
}


extension MyOrderVC: OrderDelegate {
    
    func onOrderTapped(isCompleted: Bool, order: Order) {
        let vc = OrderDetailsVC()
        vc.isCompleted = isCompleted
        vc.order = order
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onFeedbackTapped(order: Order) {
        let vc = OrderFeedbackVC()
        vc.orderId = order.id
        self.present(vc, animated: true, completion: nil)
    }
    
}
