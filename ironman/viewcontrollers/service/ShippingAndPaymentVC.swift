//
//  ShippingAndPaymentVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 9/16/21.
//

import UIKit

class ShippingAndPaymentVC: BaseVC {
    
    private let scrollWrapper = UIView()
    private var addressDownPicker: SmartDownPicker?
    private var datePicker: UIDatePicker?
    private var blurEffectView: UIView!
    
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
        
        container.addSubview(btnPlaceOrder)
        btnPlaceOrder.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(60)
            make.height.equalTo(AppConst.buttonHeight)
        }
        
        
        
        // MARK:- Scroll View
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        container.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(viewHeaderBack.snp.bottom)
            make.bottom.equalToSuperview()
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
        
        wrapperView.addSubview(labelShippingScedule)
        labelShippingScedule.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(viewHeaderBack.snp.bottom).offset(30)
        }
        
        wrapperView.addSubview(labelCollectionDate)
        labelCollectionDate.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(labelShippingScedule.snp.bottom).offset(20)
        }
        
        wrapperView.addSubview(viewDatePicker)
        viewDatePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(labelCollectionDate.snp.bottom).offset(10)
        }
        viewDatePicker.date = "Select Date"
        viewDatePicker.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dateViewTapped))
        viewDatePicker.addGestureRecognizer(tap)
        
        
        let expectedTimeContainer = UIView()
        wrapperView.addSubview(expectedTimeContainer)
        expectedTimeContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(viewDatePicker.snp.bottom).offset(20)
        }
        
        expectedTimeContainer.addSubview(ivWarning)
        ivWarning.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        expectedTimeContainer.addSubview(labelEstimatedTime)
        labelEstimatedTime.snp.makeConstraints { make in
            make.left.equalTo(ivWarning.snp.right).offset(10)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        wrapperView.addSubview(labelAddress)
        labelAddress.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(expectedTimeContainer.snp.bottom).offset(26)
        }
        
        addressDownPicker = SmartDownPicker.init(placeholder: "Select Address", dataSource: .address, validationType: .required, shouldAddMargin: false, leftIcon: "ic_pin_small")
        wrapperView.addSubview(addressDownPicker!)
        addressDownPicker!.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(labelAddress.snp.bottom).offset(10)
        }
        
        
    }
    
    private func showDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.date = Date()
        datePicker?.locale = .current
        datePicker?.preferredDatePickerStyle = .inline
        datePicker?.addTarget(self, action: #selector(dateSet), for: .valueChanged)
        addDatePickerToSubview()
    }

    private func addDatePickerToSubview() {
        guard let datePicker = datePicker else { return }
        // Give the background Blur Effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        self.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        view.bringSubviewToFront(datePicker)
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func placeOrderTapped(_ sender: Any) {
        print("place order tapped")
    }
    
    @objc private func dateViewTapped(_ sender: Any) {
        showDatePicker()
    }
    
    @objc func dateSet() {
        viewDatePicker.date = datePicker!.date.stringShort()
        blurEffectView.removeFromSuperview()
        datePicker?.removeFromSuperview()
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
        label.text = "Shipping & Payment"
        return label
    }()
    
    private let btnPlaceOrder: UIButton = {
        let button = UIButton()
        button.setTitle("Place Order", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(placeOrderTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let labelShippingScedule: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Shipping Schedule"
        return label
    }()
    
    private let labelCollectionDate: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 14)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textGrey
        label.text = "Collection Date"
        return label
    }()
    
    private let viewDatePicker: DatePickerView = {
        let view = DatePickerView(frame: .zero)
        view.layer.shadowColor =  UIColor.color(fromHexString: "EEEEEE").cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 15
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var ivWarning: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_warning_round")
        return imageView
    }()
    
    private let labelEstimatedTime: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textGrey
        label.text = "We will collect your product between 03:00 PM to 07:00 PM"
        return label
    }()
    
    private let labelAddress: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Address"
        return label
    }()
    
}
