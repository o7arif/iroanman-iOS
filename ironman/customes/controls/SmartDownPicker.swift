//
//  SmartDownPicker.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/14/21.
//

import UIKit
import DropDown
import EasyTipView

public enum DataSource: String {
    case gender = "gender"
    case area = "area"
    case none = "none"
}

protocol SmartDownPickerDelegate {
    func onChange(id: String, text: String, dataSource: DataSource?)
}

class SmartDownPicker: UIView{
    
    let downPicker = DropDown()
    var wrappingView = UIView()
    let accessoryButton: UIButton = UIButton()
    var dropDownDidChange : (String) -> Void = { _ in }

    let button = UIButton()
    var ids : [String] = []
    var texts : [String] = []
    
    var placeholder: String?
    var dataSource: DataSource?
    var validationType: ValidationType?
    var isErrorRevealed: Bool = false
    var shouldAddMargin: Bool = true
    
    var delegate: SmartDownPickerDelegate?
    
    var leftIcon:String = ""
    var toolTipView: EasyTipView?
    var toolTipCustomString: String?
    var toolTipDataSource: TTDataSource = TTDataSource.predefined
    
    
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = .black
        return aiv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDataSource()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(placeholder: String, dataSource: DataSource, validationType: ValidationType, shouldAddMargin: Bool? = true, dropDownDidChange: @escaping (String) -> ()) {
        self.init(placeholder: placeholder, dataSource: dataSource, validationType: validationType, shouldAddMargin: shouldAddMargin, leftIcon: "", dropDownDidChange: dropDownDidChange)
    }
    
    public convenience init(placeholder: String, dataSource: DataSource, validationType: ValidationType, shouldAddMargin: Bool? = true, leftIcon: String, dropDownDidChange: @escaping (String) -> ()) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.dataSource = dataSource
        self.validationType = validationType
        self.shouldAddMargin = shouldAddMargin!
        self.leftIcon = leftIcon
        self.dropDownDidChange = dropDownDidChange
        
        setupComponents()
        setupDataSource()
    }
    
    public convenience init(placeholder: String, dataSource: DataSource, validationType: ValidationType, shouldAddMargin: Bool? = true) {
        self.init(placeholder: placeholder, dataSource: dataSource, validationType: validationType, shouldAddMargin: shouldAddMargin, leftIcon: "")
    }
    
    public convenience init(placeholder: String, dataSource: DataSource, validationType: ValidationType, shouldAddMargin: Bool? = true, leftIcon: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.dataSource = dataSource
        self.validationType = validationType
        self.shouldAddMargin = shouldAddMargin!
        self.leftIcon = leftIcon
        
        setupComponents()
        setupDataSource()
    }
    
    func setupComponents(){
        
        self.backgroundColor = .clear
        
        //wrapping view
        self.addSubview(wrappingView)
        wrappingView.backgroundColor = .white
        wrappingView.layer.cornerRadius = 10
        wrappingView.layer.masksToBounds = true
        wrappingView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(AppConst.buttonHeight)
            make.left.right.equalToSuperview().inset(shouldAddMargin ? AppConst.horizontalMargin : -10)
        }
        
        var leftIconImageView = UIImageView()
        if !leftIcon.isEmpty {
            leftIconImageView.contentMode = .scaleAspectFit
            leftIconImageView = UIImageView.init(image: UIImage.init(named: leftIcon))
            wrappingView.addSubview(leftIconImageView)
            leftIconImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(12)

            }
        }

        //drop down
        button.titleLabel?.font =  OpenSans.regular.of(size: AppConst.fontSize14)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        wrappingView.addSubview(button)
        if leftIcon.isEmpty {
            button.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.left.right.equalToSuperview().inset(18)
            }
        } else {
            button.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(18)
                make.left.equalTo(leftIconImageView.snp.right).offset(10)
            }
        }
        
        //right-icon
        accessoryButton.setImage(UIImage.init(named: "ic_arrow_down"), for: .normal)
        accessoryButton.isUserInteractionEnabled = true
        accessoryButton.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        wrappingView.addSubview(accessoryButton)
        accessoryButton.isHidden = false
        accessoryButton.snp.makeConstraints { (make) in
            make.right.equalTo(button)
            make.centerY.equalTo(button)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    // development purpose
    @objc func viewPressTab(tapGestureRecognizer: UITapGestureRecognizer) {
        dropDownDidChange("")
    }
  
    func setupDataSource() {
        self.ids = []
        self.texts = []
        
        let result = FakeDataHelper.getData(dataSource: dataSource!)
        if result.count > 0 {
            self.ids = result
            self.texts = result
        }

        downPicker.anchorView = wrappingView
        downPicker.bottomOffset = CGPoint(x: 0, y: self.bounds.height)
        downPicker.dataSource = texts
        downPicker.selectionAction = { [weak self] (index, item) in
            self?.setTitle(title: item, id: self?.ids[index] ?? "")
            self?.getDownArrow()
            if (self?.delegate != nil){
                self?.delegate?.onChange(id: self?.ids[index] ?? "", text: item, dataSource: self?.dataSource)
            }
        }
        self.setTitle(title: self.placeholder!)
        button.addTarget(self, action: #selector(self.onTouch(_:)), for: .touchUpInside)
    }
    
    func setCustomErrorMessage(message: String) {
        toolTipDataSource = .custom
        toolTipCustomString = message
        displayTooltip()
        toolTipDataSource = .predefined
    }
    
    func isValid() -> Bool {
        var isPassed = true
        if validationType == .required {
            if (getId() == ""){
                isPassed = false
            }
        }
        if isPassed == false { displayTooltip() }
        return isPassed
    }
    
    func displayTooltip() {
        
        if (!isErrorRevealed) {
            toolTipView = EasyTipView(text: getToolTipString(), delegate: self)
            toolTipView!.show(forView: accessoryButton, withinSuperview: self)
            accessoryButton.setImage(UIImage.init(named: "ic_warning"), for: .normal)
            accessoryButton.isUserInteractionEnabled = true
            accessoryButton.addTarget(self, action: #selector(toggleTooltipState), for: .touchUpInside)
        }
        accessoryButton.isHidden = false
        isErrorRevealed = true
    }
    
    @objc func toggleTooltipState(_ button: UIButton) {
        if (!isErrorRevealed) {
            displayTooltip()
        } else {
            toolTipView?.dismiss()
            isErrorRevealed = false
        }
    }
    
    func getDownArrow() {
        if(isErrorRevealed) {
            toolTipView?.dismiss()
            isErrorRevealed = false
        }
        accessoryButton.setImage(UIImage.init(named: "ic_arrow_down"), for: .normal)
        accessoryButton.isUserInteractionEnabled = false
    }
    
    func getToolTipString() -> String {
        if toolTipDataSource == .predefined {
            return "\("Please Choose") \(placeholder?.lowercased() ?? "")"
        } else {
            return toolTipCustomString ?? "toolTipCustomString shouldn't be empty here"
        }
    }
    
    func setTitle(title: String, id: String = "") {
        let captionTitleText = NSMutableAttributedString(string: title)
        let textRangeForCaption = NSMakeRange(0, title.count)
        if (title == self.placeholder) {
            captionTitleText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.textGrey], range: textRangeForCaption)
            if (validationType == ValidationType.required && self.placeholder! != "") {
                captionTitleText.append(NSAttributedString(string: " *"))
                let textRangeForAsterik = NSMakeRange(self.placeholder!.count, 2)
                captionTitleText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: textRangeForAsterik)
                captionTitleText.addAttributes([NSAttributedString.Key.font : OpenSans.regular.of(size: 10)], range: textRangeForAsterik)
            }
            
            button.setAttributedTitle(captionTitleText, for: .normal)
            captionTitleText.addAttributes([NSAttributedString.Key.font : OpenSans.regular.of(size: AppConst.fontSize14)], range: textRangeForCaption)
        } else {
            captionTitleText.addAttributes([NSAttributedString.Key.font : OpenSans.regular.of(size: AppConst.fontSize14)], range: textRangeForCaption)
            captionTitleText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: textRangeForCaption)
            button.setAttributedTitle(captionTitleText, for: .normal)
        }
    }
    
    @objc func onTouch(_ sender: UIButton) {
        dropDownDidChange("")
        downPicker.show()
    }

    func setId(id : String) {
        
        if (id == "") {
            downPicker.clearSelection()
            setTitle(title: self.placeholder!,id: "\(id)")
            return
        }
        
        for i in 0..<self.ids.count {
            if self.ids[i] == id{
                downPicker.selectRow(i)
                setTitle(title: self.texts[i], id: self.ids[i])
                print(self.ids[i] + "," + self.texts[i])
                return
            }
        }
    }
    
    func setIndex(i : Int) {
        if (i == -1) { return }
        if (self.ids.count == 0) { return }
        
        downPicker.selectRow(i)
        button.setTitle(self.texts[i], for: UIControl.State.normal)
        print(self.ids[i] + "," + self.texts[i])
    }
    
    func getId () -> String {
        //validation
        if self.ids.count == 0 {return ""}
        
        let selectedText = downPicker.selectedItem
        for i in 0...self.ids.count-1 {
            if self.texts[i] == selectedText {
                return self.ids[i]
            }
        }
        return ""
    }
    
    func getTitle () -> String {
        //validation
        if self.ids.count == 0 {return ""}
        
        let selectedText = downPicker.selectedItem
        return selectedText!
    }
    
    func displayLoadingActivity() {
        self.button.isHidden = true
        wrappingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func dissmissLoadingActivity() {
        self.button.isHidden = false
        activityIndicator.removeFromSuperview()
    }
}


extension SmartDownPicker: EasyTipViewDelegate {
    public func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        isErrorRevealed = false
    }
}
