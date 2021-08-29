//
//  ChooseItemVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/27/21.
//

import UIKit
import Segmentio

class ChooseItemVC: BaseVC {
    
    private var sc = Segmentio()
    private var segmentItems = FakeDataHelper.getSegmentItems()
    
    override func viewDidLoad() {
        viewSetup()
        setupViews()
        setupSegmentControl()
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
        
        viewHeaderBack.addSubview(ivBack)
        ivBack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
        }
        
        let searchCartContainer = UIView()
        viewHeaderBack.addSubview(searchCartContainer)
        searchCartContainer.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
        }
        
        searchCartContainer.addSubview(ivCart)
        ivCart.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        searchCartContainer.addSubview(ivSearch)
        ivSearch.snp.makeConstraints { make in
            make.right.equalTo(ivCart.snp.left).offset(-10)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        viewHeaderBack.addSubview(labelHeaderTitle)
        labelHeaderTitle.snp.makeConstraints { make in
            make.bottom.equalTo(ivBack.snp.bottom)
            make.top.equalTo(ivBack.snp.top)
            make.left.equalTo(ivBack.snp.right).offset(24)
            //            make.right.equalTo(searchCartContainer.snp.left)
        }
        
        container.addSubview(sc)
        sc.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewHeaderBack.snp.bottom)
            make.height.equalTo(45)
        }
        
        
        // botom views
        
        let bottomView = UIView()
        container.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 10
        bottomView.layer.masksToBounds = true
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        bottomView.addSubview(btnCheckout)
        btnCheckout.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(20)
            make.height.equalTo(AppConst.buttonHeight)
            make.width.equalToSuperview().dividedBy(2.3)
        }
        
        let amountView = UIView()
        bottomView.addSubview(amountView)
        amountView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(20)
            make.right.equalToSuperview().dividedBy(3)
        }
        
        amountView.addSubview(labelTotal)
        labelTotal.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        amountView.addSubview(labelAmount)
        labelAmount.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        
        container.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemTVCell.self, forCellReuseIdentifier: ItemTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(sc.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(bottomView.snp.top).offset(-20)
        }
    }
    
    private func setupSegmentControl() {
        
        // segment items
        var scItems = [SegmentioItem]()
        for item in segmentItems {
            scItems.append(SegmentioItem(title: item, image: nil))
        }
        
        // segment indicator options
        let indicatorOptions = SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 2, color: .segmentColor)
        
        // segment states
        let scStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: OpenSans.regular.of(size: AppConst.fontSize14),
                titleTextColor: .textGrey
            ),
            selectedState: SegmentioState(
                backgroundColor: .segmentColor,
                titleFont: OpenSans.bold.of(size: AppConst.fontSize14),
                titleTextColor: .segmentColor   // this should be white
            ),
            highlightedState: SegmentioState(
                backgroundColor: .segmentColor,
                titleFont: OpenSans.bold.of(size: AppConst.fontSize14),
                titleTextColor: .white
            )
        )
        
        
        // segment options
        let scOptions = SegmentioOptions(backgroundColor: .white, segmentPosition: .dynamic, scrollEnabled: true, indicatorOptions: indicatorOptions, horizontalSeparatorOptions: nil, verticalSeparatorOptions: nil, imageContentMode: .scaleAspectFit, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: scStates, animationDuration: .zero)
        
        sc.setup(content: scItems, style: .onlyLabel, options: scOptions)
        sc.selectedSegmentioIndex = 0
        
        sc.valueDidChange = { segmentio, segmentIndex in
            print("\(self.segmentItems[segmentIndex]) clicked")
        }
        
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func searchTapped(_ sender: Any) {
        print("Search tapped")
    }
    
    @objc private func cartTapped(_ sender: Any) {
        print("Cart tapped")
    }
    
    @objc private func checkoutTapped(_ sender: Any) {
        print("Checkout tapped")
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
    
    private lazy var ivSearch: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_search_with_bg")
        imageView.contentMode = .scaleAspectFit
        
        // click event
        let tap = UITapGestureRecognizer(target: self, action: #selector(searchTapped(_:)))
        tap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private lazy var ivCart: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_cart")
        imageView.contentMode = .scaleAspectFit
        
        // click event
        let tap = UITapGestureRecognizer(target: self, action: #selector(cartTapped(_:)))
        tap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private let labelHeaderTitle: UILabel = {
        let label = UILabel()
        label.font = OpenSans.semiBold.of(size: 20)     // should be Poppins Semibold 20
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Service name"
        return label
    }()
    
    private let labelTotal: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Total"
        return label
    }()
    
    private let labelAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "৳70.00"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let btnCheckout: UIView = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // click action
        button.addTarget(self, action: #selector(checkoutTapped(_:)), for: .touchUpInside)
        return button
    }()
}


extension ChooseItemVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTVCell.identifier) as! ItemTVCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
