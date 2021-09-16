//
//  MyCartVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/28/21.
//

import UIKit

class MyCartVC: BaseVC {
    
    private let scrollWrapper = UIView()
    
    override func viewDidLoad() {
        viewSetup()
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
        
//        if CacheData.instance.isLoggedIn() {
//            emptyListMessage()
//        } else {
//            authentionRequiredMessage()
//        }
        
        cartWithItemsUI()
    }
    
    
    private func authentionRequiredMessage() {
        let authRequiredContainer = UIView()
        container.addSubview(authRequiredContainer)
        authRequiredContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(46)
        }
        
        authRequiredContainer.addSubview(ivBox)
        ivBox.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        authRequiredContainer.addSubview(labelNotAuthenticated)
        labelNotAuthenticated.snp.makeConstraints { make in
            make.top.equalTo(ivBox.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
        container.addSubview(btnSignIn)
        btnSignIn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
        
    }
    
    
    
    // MARK: EMPTY CART LIST
    
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
        
        emptyListContainer.addSubview(labelEmptyCartList)
        labelEmptyCartList.snp.makeConstraints { make in
            make.top.equalTo(ivBox.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
    
    // MARK: CART WITH ITEMS
    
    private func cartWithItemsUI() {
        
        
        // botom views
        
        let bottomView = UIView()
        self.view.addSubview(bottomView)
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
        
        amountView.addSubview(labelCheckoutTotal)
        labelCheckoutTotal.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        amountView.addSubview(labelCheckoutAmount)
        labelCheckoutAmount.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        
        
        // MARK:- Scroll View
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
            make.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(scrollWrapper)
        scrollWrapper.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(820)
        }
        
        let wrapperView = UIView()
        scrollWrapper.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapperView.addSubview(labelItems)
        labelItems.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(30)
        }
        
        wrapperView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(CartItemTVCell.self, forCellReuseIdentifier: CartItemTVCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelItems.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        
        // coupon
        
        wrapperView.addSubview(labelCouponCode)
        labelCouponCode.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(50)
            make.left.equalToSuperview().inset(20)
        }
        
        let couponContainer = UIView()
        couponContainer.backgroundColor = .white
        couponContainer.layer.cornerRadius = 10
        couponContainer.layer.masksToBounds = true
        wrapperView.addSubview(couponContainer)
        couponContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelCouponCode.snp.bottom).offset(15)
            make.height.equalTo(50)
//            make.bottom.equalToSuperview()
        }

        couponContainer.addSubview(couponField)
        couponField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(90)
            make.top.bottom.equalToSuperview()
        }
        
        couponContainer.addSubview(btnApply)
        btnApply.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
        
        
        // order summary
        
        wrapperView.addSubview(labelOrderSummary)
        labelOrderSummary.snp.makeConstraints { make in
            make.top.equalTo(couponContainer.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
        }
        
        let orderContainer = UIView()
        orderContainer.backgroundColor = .white
        orderContainer.layer.cornerRadius = 10
        orderContainer.layer.masksToBounds = true
        wrapperView.addSubview(orderContainer)
        orderContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelOrderSummary.snp.bottom).offset(15)
        }
        
        orderContainer.addSubview(labelSubTotal)
        labelSubTotal.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(20)
        }
        
        orderContainer.addSubview(labelSubTotalAmount)
        labelSubTotalAmount.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(20)
        }
        
        orderContainer.addSubview(labelVAT)
        labelVAT.snp.makeConstraints { make in
            make.top.equalTo(labelSubTotal.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        orderContainer.addSubview(labelVATAmount)
        labelVATAmount.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(labelVAT.snp.top)
        }
        
        orderContainer.addSubview(labelDeliveryCost)
        labelDeliveryCost.snp.makeConstraints { make in
            make.top.equalTo(labelVAT.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        orderContainer.addSubview(labelDeliveryCostAmount)
        labelDeliveryCostAmount.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(labelDeliveryCost.snp.top)
        }
        
        orderContainer.addSubview(labelDiscount)
        labelDiscount.snp.makeConstraints { make in
            make.top.equalTo(labelDeliveryCost.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        orderContainer.addSubview(labelDiscountAmount)
        labelDiscountAmount.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(labelDiscount.snp.top)
        }
        
        orderContainer.addSubview(labelTotal)
        labelTotal.snp.makeConstraints { make in
            make.top.equalTo(labelDiscount.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        orderContainer.addSubview(labelTotalAmount)
        labelTotalAmount.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(labelTotal.snp.top)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
        wrapperView.addSubview(labelMessage)
        labelMessage.snp.makeConstraints { make in
            make.top.equalTo(orderContainer.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func signInTapped(_ sender: Any) {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    @objc private func applyTapped(_ sender: Any) {
        print("apply tapped")
    }
    
    @objc private func checkoutTapped(_ sender: Any) {
        self.navigationController?.pushViewController(ShippingAndPaymentVC(), animated: true)
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
        label.text = "My Cart"
        return label
    }()
    
    private let ivBox: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_cart_box")
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
    
    private let btnSignIn: UIView = {
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
    
    
    // empty cart list
    
    private let labelEmptyCartList: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Your Cart is Empty."
        return label
    }()
    
    
    // cart with items
    
    private let labelItems: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Items"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let labelCouponCode: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Coupon Code"
        return label
    }()
    
    private let couponField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter coupon code here"
        textField.backgroundColor = .clear
        textField.keyboardType = .default
        textField.returnKeyType = .search
        textField.autocorrectionType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = OpenSans.regular.of(size: AppConst.fontSize14)
        textField.textColor = .textBlack
        textField.clearButtonMode = .never
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private let btnApply: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.primary.withAlphaComponent(0.5), for: .normal)
        button.backgroundColor = .primary.withAlphaComponent(0.08)
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        // click action
        button.addTarget(self, action: #selector(applyTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let labelOrderSummary: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Order Summary"
        return label
    }()
    
    // sub total
    private let labelSubTotal: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Sub total"
        return label
    }()
    
    private let labelSubTotalAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .textBlack
        label.text = "৳85.00"
        return label
    }()
    
    // vat
    private let labelVAT: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "0% VAT"
        return label
    }()
    
    private let labelVATAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .textBlack
        label.text = "৳00.00"
        return label
    }()
    
    // delivery cost
    private let labelDeliveryCost: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Delivery Cost"
        return label
    }()
    
    private let labelDeliveryCostAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .textBlack
        label.text = "৳00.00"
        return label
    }()
    
    // discount
    private let labelDiscount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Discount"
        return label
    }()
    
    private let labelDiscountAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .textRed
        label.text = "-৳15.00"
        return label
    }()
    
    // vat
    private let labelTotal: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Total"
        return label
    }()
    
    private let labelTotalAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .textBlack
        label.text = "৳70.00"
        return label
    }()
    
    
    // message
    private let labelMessage: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .primary
        label.text = "*If you order over 100TK, you will get Free Delivery"
        return label
    }()
    
    
    // checkout section
    
    private let labelCheckoutTotal: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Total"
        return label
    }()
    
    private let labelCheckoutAmount: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "৳70.00"
        return label
    }()
    
    private let btnCheckout: UIButton = {
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



extension MyCartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTVCell.identifier) as! CartItemTVCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

