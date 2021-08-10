//
//  HomeVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/15/21.
//

import UIKit
import SnapKit
import AdvancedPageControl

class HomeVC: UIViewController {
    
    private let container = UIView()
    private var pageControl: AdvancedPageControlView = AdvancedPageControlView(frame: .zero)
    
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
            make.height.equalTo(250)
        }
        
        let profileContainer = UIView()
        container.addSubview(profileContainer)
        profileContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        profileContainer.addSubview(ivProfile)
        ivProfile.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        profileContainer.addSubview(ivCart)
        ivCart.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
        }
        
        profileContainer.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.left.equalTo(ivProfile.snp.right).offset(20)
            //            make.right.equalTo(ivCart.snp.left).offset(-20)
            make.top.equalToSuperview()
        }
        
        profileContainer.addSubview(labelAddress)
        labelAddress.snp.makeConstraints { make in
            make.left.equalTo(ivProfile.snp.right).offset(20)
            //            make.right.equalTo(ivCart.snp.left).offset(-20)
            make.bottom.equalToSuperview()
        }
        
        
        // promotions
        
        container.addSubview(labelPromotion)
        labelPromotion.snp.makeConstraints { make in
            make.top.equalTo(profileContainer.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(cvPromotion)
        cvPromotion.snp.makeConstraints { make in
            make.top.equalTo(labelPromotion.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(175)
        }
        
        
        // page indicator
        pageControl.drawer = ThinWormDrawer(numberOfPages: 5,
                                            space: 16.0,
                                            indicatorColor: .primary,
                                            dotsColor: .primary,
                                            isBordered: false,
                                            borderWidth: 0.0,
                                            indicatorBorderColor: .clear,
                                            indicatorBorderWidth: 0.0)
        container.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(cvPromotion.snp.bottom)
            make.left.right.equalToSuperview()
        }

        
        // services
        
        container.addSubview(labelService)
        labelService.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(cvService)
        cvService.snp.makeConstraints { make in
            make.top.equalTo(labelService.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(165)
        }
        
    }
    
    
    
    // MARK: CLICK ACTIONS
    
    @objc private func cartTapped(_ sender: Any) {
        self.navigationController?.pushViewController(MyCartVC(), animated: true)
    }
    
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let viewHeaderBack: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    
    private let ivProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "ic_profile")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.color(fromHexString: "A7A8A9").cgColor
        imageView.layer.shadowOffset = CGSize(width: 1, height: 2)
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowRadius = 10
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "John Doe"
        return label
    }()
    
    private let labelAddress: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Dhaka, Bangladesh"
        return label
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
    
    
    // promotions
    
    private let labelPromotion: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Promotions"
        return label
    }()
    
    private lazy var cvPromotion: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 275, height: 140)
        layout.minimumLineSpacing = 20
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PromotionCVCell.self, forCellWithReuseIdentifier: PromotionCVCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // for horizontal scrolling
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    
    // services
    
    private let labelService: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 24)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .textBlack
        label.text = "Our Services"
        return label
    }()
    
    private lazy var cvService: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.minimumLineSpacing = 20
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ServiceCVCell.self, forCellWithReuseIdentifier: ServiceCVCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // for horizontal scrolling
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
}



extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvPromotion {
            return 5
        } else if collectionView == cvService {
            return 12
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvPromotion {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCVCell.identifier, for: indexPath) as! PromotionCVCell
            return cell
        } else if collectionView == cvService {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCVCell.identifier, for: indexPath) as! ServiceCVCell
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        pageControl.setPageOffset(offSet / width)
    }
    
}
