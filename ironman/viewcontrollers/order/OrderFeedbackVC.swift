//
//  OrderFeedbackVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/19/21.
//

import UIKit
import Cosmos
import Toaster

class OrderFeedbackVC: UIViewController {
    
    var orderId = -1
    
    private var tvComment = NotesTextView()
    private let container = UIView()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(container)
        container.backgroundColor = .white
        container.layer.cornerRadius = 25
        container.layer.masksToBounds = true
        container.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
        
        container.addSubview(ivImg)
        ivImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
        }
        
        container.addSubview(labelQuestion)
        labelQuestion.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(ivImg.snp.bottom).offset(30)
        }
        
        container.addSubview(labelMessage)
        labelMessage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(labelQuestion.snp.bottom).offset(15)
        }
        
        container.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(labelMessage.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        // comment
        tvComment.placeholder = "Write us your valuable comments...."
        container.addSubview(tvComment)
        tvComment.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(ratingView.snp.bottom).offset(15)
            make.height.equalTo(90)
        }
        
        container.addSubview(btnSubmit)
        btnSubmit.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(tvComment.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(AppConst.buttonHeight)
        }
    }
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func submitTapped(_ sender: Any) {
        submitRequest()
//        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private lazy var ivImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_order_feedback")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelQuestion: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "How was Laundry Service?"
        return label
    }()
    
    private let labelMessage: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .textBlack
        label.text = "Your feedback will help us to improve the Laundry Service Experience."
        return label
    }()
    
    private lazy var ratingView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.settings.updateOnTouch = true
        cosmos.settings.starSize = 22
        cosmos.settings.starMargin = 10
        cosmos.settings.filledImage = UIImage.init(named: "ic_star_fill")
        cosmos.settings.emptyImage = UIImage.init(named: "ic_star_empty")
        cosmos.rating = 5
        return cosmos
    }()
    
    private let btnSubmit: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = CGFloat(AppConst.buttonHeight / 2)
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // click action
        button.addTarget(self, action: #selector(submitTapped(_:)), for: .touchUpInside)
        return button
    }()
    
}




// MARK: API CALLING

extension OrderFeedbackVC {
    
    private func submitRequest() {
        let params = [
            "order_id": orderId,
            "rating": ratingView.rating,
            "content": tvComment.text ?? ""
        ] as [String:Any]
        
        Networking.instance.call(api: "ratings", method: .post, parameters: params) { (responseModel) in
            if responseModel.code == 200 {
                Toast(text: "Thanks for your feedback").show()
                self.dismiss(animated: true, completion: nil)
            } else {
                Toast(text: responseModel.message ?? "Something went wrong. Please try again later.").show()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
