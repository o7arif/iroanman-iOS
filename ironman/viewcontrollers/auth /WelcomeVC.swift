//
//  WelcomeVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 7/12/21.
//

import UIKit
import SnapKit
import AdvancedPageControl

struct WelcomeAssest {
    var title: String
    var image: UIImage
}

class WelcomeVC: BaseVC {
    
    private var pageControl: AdvancedPageControlView = AdvancedPageControlView(frame: .zero)
    private var welcomeAssets = [WelcomeAssest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.backgroundColor = .primary
        
        setupViews()
        setupData()
    }
    
    private func setupViews() {
        
        // logo
        container.addSubview(ivLogo)
        ivLogo.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        // collection view
        container.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(ivLogo.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.bounds.width-100)
        }
        
        // page indicator
        pageControl.drawer = ExtendedDotDrawer(numberOfPages: 3,
                                               space: 16.0,
                                               indicatorColor: .white,
                                               dotsColor: .white,
                                               isBordered: false,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .clear,
                                               indicatorBorderWidth: 0.0)
        container.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        
        // label
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(60)
        }
        
        // button
        container.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(50)
        }
    }
    
    private func setupData() {
        welcomeAssets.append(WelcomeAssest(title: "Get Stuff Washed", image: UIImage(named: "img_welcome")!))
        welcomeAssets.append(WelcomeAssest(title: "Premium Washing", image: UIImage(named: "img_welcome")!))
        welcomeAssets.append(WelcomeAssest(title: "Dry Cleaning", image: UIImage(named: "img_welcome")!))
    }
    
    
    // MARK: ATTRIBUTE INITIALIZATION
    
    private let ivLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: view.bounds.width-100, height: view.bounds.width-100)
        layout.minimumLineSpacing = 20
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WelcomeCVCell.self, forCellWithReuseIdentifier: WelcomeCVCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // for horizontal scrolling
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = OpenSans.regular.of(size: 14)
        label.text = "Ready to Make Your Life Easier with Laundry Service?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Let`s Get Started", for: .normal)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.primary, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = OpenSans.bold.of(size: 15)
        button.clipsToBounds = true
        button.addRightIcon(image: UIImage(named: "ic_arrow_right")!)
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.layer.shadowColor = UIColor.color(fromHexString: "808082").cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 25
        button.layer.masksToBounds = false
        
        // click action
        button.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        return button
    }()
    
}


// MARK: TAP ACTIONS

extension WelcomeVC {
    
    @objc private func getStartedTapped() {
        self.navigationController?.pushViewController(TabNavigationVC(), animated: true)
    }
    
}



// MARK: COLLECTION VIEW SETUP

extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomeAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCVCell.identifier, for: indexPath) as! WelcomeCVCell
        cell.configure(with: welcomeAssets[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        pageControl.setPageOffset(offSet / width)
    }
    
}
