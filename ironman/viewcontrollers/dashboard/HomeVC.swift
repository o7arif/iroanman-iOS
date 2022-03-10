//
//  HomeVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/15/21.
//

import UIKit
import SnapKit
import AdvancedPageControl
import Alamofire

class HomeVC: UIViewController /*& ServiceTapListener*/ {
    
    private let container = UIView()
    
    private var banners = [Banner]()
    private var services = [Service]()
    
    override func viewDidLoad() {
        setupViews()
        fetchBanners()
        fetchServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLoggedUserData()
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
            make.height.width.equalTo(44)
        }
        
        profileContainer.addSubview(ivCart)
        ivCart.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
        }
        
        profileContainer.addSubview(labelName)
        labelName.snp.makeConstraints { make in
            make.left.equalTo(ivProfile.snp.right).offset(20)
            make.top.equalToSuperview()
        }
        
        profileContainer.addSubview(labelAddress)
        labelAddress.snp.makeConstraints { make in
            make.left.equalTo(ivProfile.snp.right).offset(20)
            make.bottom.equalToSuperview()
        }
        
        
        // promotions
        
        container.addSubview(labelPromotion)
        labelPromotion.snp.makeConstraints { make in
            make.top.equalTo(profileContainer.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(cvBanner)
        cvBanner.snp.makeConstraints { make in
            make.top.equalTo(labelPromotion.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(175)
        }

        // services
        container.addSubview(labelService)
        labelService.snp.makeConstraints { make in
            make.top.equalTo(cvBanner.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        container.addSubview(cvService)
        cvService.snp.makeConstraints { make in
            make.top.equalTo(labelService.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(245)
        }
        
    }
    
    
    
    
    // MARK: SETUP DATA
    
    private func setupLoggedUserData() {
        guard let user = CacheData.instance.getLoggedUser() else {
            labelName.text = L10n.Label.guestUser
            labelAddress.attributedText = ResourceUtil.makeUnderlineAndColoredText(string: L10n.Button.tapHereToLogin, startIndex: "Tap here to ".count, length: "Login".count, color: .blue)
            return
        }
        
        labelName.text = user.name
        labelAddress.text = L10n.Label.unknownAddress
        ivProfile.load(url: URL(string: user.profilePhoto)!)
    }
    
    
    
    
    // MARK: TAP ACTIONS
    
    @objc private func cartTapped(_ sender: Any) {
        self.navigationController?.pushViewController(MyCartVC(), animated: true)
    }
    
    @objc private func loginTapped(_ sender: Any) {
        if CacheData.instance.isLoggedIn() {
            return
        }
        self.navigationController?.pushViewController(LoginVC(), animated: true)
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
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = OpenSans.bold.of(size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = L10n.Label.guestUser
        return label
    }()
    
    private lazy var labelAddress: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = ""
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapped(_:)))
        label.addGestureRecognizer(tap)
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
        label.text = L10n.Label.promotions
        return label
    }()
    
    private lazy var cvBanner: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 275, height: 140)
        layout.minimumLineSpacing = 20
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCVCell.self, forCellWithReuseIdentifier: BannerCVCell.identifier)
        
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
        label.text = L10n.Label.ourServices
        return label
    }()
    
    private lazy var cvService: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 150, height: 240)
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
        if collectionView == cvBanner {
            return banners.count
        } else if collectionView == cvService {
            return services.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVCell.identifier, for: indexPath) as! BannerCVCell
            if banners.count > indexPath.row {
                cell.configure(with: banners[indexPath.row])
            }
            return cell
        } else if collectionView == cvService {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCVCell.identifier, for: indexPath) as! ServiceCVCell
//            cell.listener = self
            if services.count > indexPath.row {
                cell.configure(with: services[indexPath.row])
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvBanner {
            handleBannerTap()
        } else if collectionView == cvService {
            let service = services[indexPath.row]
            serviceTapped(item: service)
        }
    }
    
    
    private func handleBannerTap() {
        
    }
    
    private func serviceTapped(item: Service) {
        let vc = ChooseItemVC()
        vc.service = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}






// MARK: API CALLING
extension HomeVC {
    private func fetchBanners() {
        
        banners.removeAll()
        
        Networking.instance.call(api: "banners", method: .get, parameters: [:]) { (responseModel) in
            if responseModel.code == 200 {
                guard let dataDictionary = responseModel.body["data"] as? Dictionary<String, Any> else {
                    return
                }
                
                guard let dictionary = dataDictionary["banners"] as? Array<Dictionary<String, Any>> else {
                    return
                }
                
                for i in 0..<dictionary.count {
                    let banner = Banner.init(fromDictionary: dictionary[i])
                    self.banners.append(banner)
                }
                
                DispatchQueue.main.async {
                    self.cvBanner.reloadData()
                }
            } else {
                self.cvBanner.reloadData()
            }
        }
        
    }
    
    
    private func fetchServices() {
        
        services.removeAll()
        
        Networking.instance.call(api: "services", method: .get, parameters: [:]) { (responseModel) in
            if responseModel.code == 200 {
                guard let dataDictionary = responseModel.body["data"] as? Dictionary<String, Any> else {
                    return
                }
                
                guard let dictionary = dataDictionary["services"] as? Array<Dictionary<String, Any>> else {
                    return
                }
                
                for i in 0..<dictionary.count {
                    let service = Service.init(fromDictionary: dictionary[i])
                    self.services.append(service)
                }
                
                DispatchQueue.main.async {
                    self.cvService.reloadData()
                }
            } else {
                self.cvService.reloadData()
            }
        }
        
    }
}
