//
//  TabNavigationVC.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/6/21.
//

import UIKit
class TabNavigationVC: UIViewController {
    
    fileprivate let tabView = UIView()
    fileprivate let bottomBarView = UIView()
    fileprivate let containerView = UIView()

    var tabHome: GMFTabViewItem?
    var tabOrder: GMFTabViewItem?
    var tabNotifcation : GMFTabViewItem?
    var tabProfile : GMFTabViewItem?
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    var topMargen =  10
    var heightWidth =  23
    
    let homeVC = HomeVC()
    let myOrderVC = MyOrderVC()
    let notifcationVC = NotificationVC()
    let profileVC = ProfileVC()
    
    let sectinView = UIView()
    var viewDividerWidth :CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDividerWidth = (view.frame.size.width/5)
        viewControllers = [homeVC, myOrderVC, notifcationVC, profileVC]
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView () {
        
        let wrappingView = UIView()
        view.backgroundColor = .gray
        self.view.addSubview(wrappingView)
        wrappingView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        wrappingView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        /* MARK: tab view-------------------- */
        wrappingView.addSubview(tabView)
        tabView.backgroundColor = .white
        tabView.clipsToBounds = true
        tabView.layer.cornerRadius = 20
        tabView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        // shadow
        tabView.layer.shadowColor = UIColor.black.cgColor
        tabView.layer.shadowOffset = CGSize(width: 3, height: 3)
        tabView.layer.shadowOpacity = 0.7
        tabView.layer.shadowRadius = 4.0
        tabView.layer.masksToBounds = true

        tabView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            if DeviceInfoHelper.instance.safe_area_bottom > 0 {
                make.height.equalTo(90)
            } else {
                make.height.equalTo(70)
            }
        }
        
        let transactionView = UIView()
        tabView.addSubview(transactionView)
        transactionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        //MARK:TAB ITEM: home
        tabHome = GMFTabViewItem.init(icon: "ic_order_deactive", title: "Home") {
            self.didPressTab(selectedIndex: 0)
        }
        tabHome?.isHiddenAction = false
        transactionView.addSubview(tabHome!)
        tabHome!.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(4)
        }
        
        //MARK:TAB ITEM: my order
        tabOrder = GMFTabViewItem.init(icon: "ic_order_deactive", title: "My Order") {
            self.didPressTab(selectedIndex: 1)
        }
        transactionView.addSubview(tabOrder!)
        tabOrder!.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(tabHome!.snp.right)
            make.width.equalToSuperview().dividedBy(4)
        }
        
        //MARK:TAB ITEM: profile
        tabProfile = GMFTabViewItem.init(icon: "ic_profile_deactive", title: "Profile") {
            self.didPressTab(selectedIndex: 3)
        }
        transactionView.addSubview(tabProfile!)
        tabProfile!.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().dividedBy(4)
        }
       
        //MARK: TAB ITEM: notification
        tabNotifcation = GMFTabViewItem.init(icon: "ic_notification_deactive", title: "Notification") {
            self.didPressTab(selectedIndex: 2)
        }
        transactionView.addSubview(tabNotifcation!)
        tabNotifcation!.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(tabProfile!.snp.left)
            make.width.equalToSuperview().dividedBy(4)
        }
        didPressTab(selectedIndex: 0)
        
        
        // Home custom view
        let homeView = UIImageView()
        homeView.image = UIImage(named: "ic_home")
        homeView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(homeTapped(_:)))
        homeView.addGestureRecognizer(tap)
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func homeTapped(_ sender: Any) {
        didPressTab(selectedIndex: 0)
    }
    
    func didPressTab(selectedIndex:Int) {

        selected(selectedIndex)
        print("selectedIndex: \(selectedIndex)")
        
        //Use the previousIndex to access the previous ViewController from the viewControllers array.
        let previousVC = viewControllers[selectedIndex]
        //Remove the previous ViewController
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()

        //Use the selectedIndex to access the current ViewController from the viewControllers array.
        let vc = viewControllers[selectedIndex]
        //Add the new ViewController to display view
        addChild(vc)

        //Adjusts the size of the ViewController view add it as a subView of the contentView.
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        //Call the viewDidAppear method of the coming ViewController
        vc.didMove(toParent: self)
    }

    /* ==================== acttion tab ==================== */
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        let vc = BaseSendGiftViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func selected(_ index:Int)  {
        switch index {
        case 0:
            self.sectinView.moveView(self.sectinView, toX: (self.viewDividerWidth*0.1))
            
            self.tabHome!.isTabSelected(isIelected: true)
            self.tabOrder!.isTabSelected(isIelected: false)
            self.tabNotifcation!.isTabSelected(isIelected: false)
            self.tabProfile!.isTabSelected(isIelected: false)

            break
        case 1:
            
            self.sectinView.moveView(self.sectinView, toX: (self.viewDividerWidth*1.0))
            self.tabHome!.isTabSelected(isIelected: false)
            self.tabOrder!.isTabSelected(isIelected: true)
            self.tabNotifcation!.isTabSelected(isIelected: false)
            self.tabProfile!.isTabSelected(isIelected: false)
            break

        case 2:
            self.sectinView.moveView(self.sectinView, toX: (self.viewDividerWidth*3.0))
            self.tabHome!.isTabSelected(isIelected: false)
            self.tabOrder!.isTabSelected(isIelected: false)
            self.tabNotifcation!.isTabSelected(isIelected: true)
            self.tabProfile!.isTabSelected(isIelected: false)
            break
        case 3:
            self.sectinView.moveView(self.sectinView, toX: (self.viewDividerWidth*4.0))
            self.tabHome!.isTabSelected(isIelected: false)
            self.tabOrder!.isTabSelected(isIelected: false)
            self.tabNotifcation!.isTabSelected(isIelected: false)
            self.tabProfile!.isTabSelected(isIelected: true)
            break
   
        default:
            break
        }
        print("index: \(index)")

    }
    
    
  
    
}
