//
//  GMFTextField.swift
//  rate-hammer
//
//  Created by Mohammad Faisal on 28/5/19.
//  Copyright © 2019 Media 365. All rights reserved.
//

import UIKit
import SnapKit
import EasyTipView






public enum DataType {
    case email
    case password
    case name
    case number
    case currency
    case mobile
}


public enum IconType {
    case leftSide
    case rightSide
    case BothSide
    case none
    
    
}

public enum ValidationType {
    case optional
    case required
}

public enum TTDataSource {
    case predefined
    case custom
}

public enum ExtendedValidationType{
    case none
    case inBetweenRange
    case inBetweenLength
}

open class SmartTextField: UIView {
    
    var caption: String?
    var placeholder: String?
    var dataType: DataType?
    let iconImageView = UIImageView()
    var validationType: ValidationType?
    var extendedValidationType: ExtendedValidationType?
    var isErrorRevealed: Bool = false
    var isRoundTextField: Bool = false
    
    let textField: UITextField = UITextField()
    let accessoryButton: UIButton = UIButton()
    let leftIconButton: UIButton = UIButton()
    var leftIcon:String?
    var toolTipView: EasyTipView?
    var toolTipDataSource: TTDataSource = TTDataSource.predefined
    var toolTipCustomString: String?
    var shouldAddMargin: Bool = true
    
    var extendedValidationStart: Int?
    var extendedValidationEnd: Int?
    var textFieldDidChange : (String) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init (placeholder: String, dataType: DataType, validationType: ValidationType, shouldAddMargin: Bool? = true) {
        self.init (placeholder: placeholder, dataType: dataType, validationType: validationType, shouldAddMargin: shouldAddMargin, leftIcon: "")
    }
    
    public convenience init (placeholder: String, dataType: DataType, validationType: ValidationType, shouldAddMargin: Bool? = true, leftIcon:String){
        self.init(frame: .zero)
        self.caption = placeholder
        self.placeholder = placeholder
        self.dataType = dataType
        self.validationType = validationType
        
        self.shouldAddMargin = shouldAddMargin!
        self.leftIcon = leftIcon
        
        var preferences = EasyTipView.Preferences()
        preferences.drawing.backgroundColor = .black//UIColor(hue:0.58, saturation:0.1, brightness:1, alpha:1)
        preferences.drawing.foregroundColor = .white//UIColor.darkGray
        preferences.drawing.textAlignment = NSTextAlignment.center
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.right
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 100, y: 0)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: -100, y: 0)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1
        preferences.animating.dismissDuration = 1
        EasyTipView.globalPreferences = preferences
        
        setupComponents()
    }
    
    
    func setupComponents(){
        
        let wrapperView = UIView()
        wrapperView.layer.cornerRadius = 10.0
        wrapperView.layer.borderWidth = 0
        wrapperView.backgroundColor = .white
        wrapperView.layer.shadowColor = UIColor.white.cgColor
        wrapperView.layer.shadowOpacity = 0.2
        wrapperView.layer.shadowRadius = 1.0
        wrapperView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(shouldAddMargin ? AppConst.horizontalMargin:0)
            make.height.equalTo(AppConst.inputField)
        }
        
        var leftIconImageView = UIImageView()
        if !leftIcon!.isEmpty {
            leftIconImageView.contentMode = .scaleAspectFit
            leftIconImageView = UIImageView.init(image: UIImage.init(named: leftIcon ?? ""))
            wrapperView.addSubview(leftIconImageView)
            leftIconImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(12)

            }
        }
        

        textField.delegate = self
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.font = OpenSans.regular.of(size: AppConst.fontSize14)
        textField.textColor = .black
        textField.attributedPlaceholder =  NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.color(fromHexString: "788493")])
        
        
      
        
        
        wrapperView.addSubview(textField)
        if !leftIcon!.isEmpty {
            textField.snp.makeConstraints { (make) in
                make.top.right.bottom.equalToSuperview()
                make.height.equalTo(AppConst.inputField)
                make.left.equalTo(leftIconImageView.snp.right).offset(10)
                
            }
        } else {
            textField.snp.makeConstraints { (make) in
                make.top.right.bottom.equalToSuperview()
                make.height.equalTo(AppConst.inputField)
                make.left.equalToSuperview().inset(10)
                
            }
        }
        
        
        
        //keyboard
        textField.keyboardType = dataType == DataType.email ? UIKeyboardType.emailAddress : dataType == DataType.number ? UIKeyboardType.numberPad : dataType == DataType.currency ? UIKeyboardType.decimalPad : dataType == DataType.mobile ? UIKeyboardType.phonePad : UIKeyboardType.default
        textField.isSecureTextEntry = dataType == DataType.password ? true : false
        
        //turn off auto-capitalization for email since apple isn't that smart yet
        if (dataType == .email){
            textField.autocapitalizationType = .none
        }
        
        
        //        if (dataType == .currency){
        //
        //            leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        //
        //            let currencySignLabel = UILabel.init(frame: CGRect.init(x: 2, y: 0, width: 30, height: 20))
        //            currencySignLabel.font = SFUIDisplay.regular.of(size: 14)
        //            currencySignLabel.textColor = .border
        //            currencySignLabel.textAlignment = .center
        //            currencySignLabel.text = "£"
        //            leftPaddingView.addSubview(currencySignLabel)
        //
        //            let verticalLine = UIView.init(frame: CGRect.init(x: 30, y: 0, width: 1, height: 20))
        //            verticalLine.backgroundColor = .border
        //            leftPaddingView.addSubview(verticalLine)
        //        }
        
        
        
        //right-icon
        accessoryButton.setImage(UIImage.init(named: "ic_warning"), for: .normal)
        accessoryButton.addTarget(self, action: #selector(toggleTooltipState), for: .touchUpInside)
        accessoryButton.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        self.addSubview(accessoryButton)
        accessoryButton.isHidden = true
        
        //not so fast. what if its datatype is password?
        if (dataType == .password){
            accessoryButton.setImage(UIImage.init(named: "ic_hide_password"), for: .normal)
            accessoryButton.removeTarget(self, action: #selector(toggleTooltipState), for: .touchUpInside)
            accessoryButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
            accessoryButton.isHidden = false
        }
        
        wrapperView.addSubview(accessoryButton)
        
        accessoryButton.snp.makeConstraints { (make) in
            make.right.equalTo(textField).inset(11)
            make.centerY.equalTo(textField)
            make.width.height.equalTo(30)
        }
        
        
    }
    
    @objc func toggleVisibility(_ button: UIButton){
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        
        if (textField.isSecureTextEntry){
            accessoryButton.setImage(UIImage.init(named: "ic_hide_password"), for: .normal)
        }else{
            accessoryButton.setImage(UIImage.init(named: "ic_show_password"), for: .normal)
        }
    }
    
    @objc func toggleTooltipState(_ button: UIButton){
        print("toggleTooltipState")
        if (!isErrorRevealed){
            displayTooltip()
        }else{
            toolTipView?.dismiss()
            isErrorRevealed = false
        }
    }
    
    func displayTooltip(){
        if (!isErrorRevealed){
            toolTipView = EasyTipView(text: getToolTipString(), delegate: self)
            toolTipView!.show(forView: accessoryButton, withinSuperview: self)
            
            if (dataType == .password){
                accessoryButton.setImage(UIImage.init(named: "ic_warning"), for: .normal)
                accessoryButton.removeTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
                accessoryButton.addTarget(self, action: #selector(toggleTooltipState), for: .touchUpInside)
            }
        }
        accessoryButton.isHidden = false
        isErrorRevealed = true
    }
    
    func setCustomErrorMessage(message: String){
        toolTipDataSource = .custom
        toolTipCustomString = message
        displayTooltip()
        toolTipDataSource = .predefined
    }
    
    func getToolTipString() -> String{
        if toolTipDataSource == .predefined {
            if textField.text?.count == 0{
                return "\(caption!) is empty"
            }else{
                if (dataType == DataType.email){
                    return "Invalid email address"
                }else if (dataType == DataType.password){
//                    return "At least 8 character long and should contain 1 of each - number, upper and lower case"
                    return "At least 6 character long"
                }else if (dataType == DataType.mobile){
                    return "Invalid mobile number"
                }else if ((dataType == DataType.number || dataType == DataType.currency) && (extendedValidationType == ExtendedValidationType.none || extendedValidationType == nil)){
                    return "Invalid number"
                }else if extendedValidationType != ExtendedValidationType.none{
                    if (extendedValidationType == ExtendedValidationType.inBetweenRange){
                        return "Must be between: \(extendedValidationStart ?? 0) to \(extendedValidationEnd ?? 0)"
                    }else if (extendedValidationType == ExtendedValidationType.inBetweenLength){
                        if (extendedValidationStart == extendedValidationEnd){
                            return "Must be \(extendedValidationStart ?? 0) digits"
                        }else{
                            return "Must be between \(extendedValidationStart ?? 0) - \(extendedValidationEnd ?? 0) digits"
                        }
                    }
                    else{
                        return "TT: not defined"
                    }
                }else {
                    return "Please enter correct information"
                }
            }
        } else {
            return toolTipCustomString ?? "toolTipCustomString shouldn't be empty here"
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField){
        
        
    }
    
    
    func textUpdate(value: String = "",interactionEnabled : Bool = false ){
        textField.text = value
        textField.isUserInteractionEnabled = interactionEnabled
        
    }
    
    @discardableResult
    func isValid() -> Bool{
        
        self.toolTipDataSource = .predefined
        if (validationType == ValidationType.optional) { return true }
        
        var isPassed = true // its passed as default unless its proven failed
        if (self.textField.text?.count == 0){
            isPassed = false
        }else{
            if dataType == DataType.email {
                let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let predict = NSPredicate(format:"SELF MATCHES %@", regex)
                isPassed = predict.evaluate(with: self.textField.text)
            }else if dataType == DataType.password{
//                let regex = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,20})"
                
                //version 2
                let regex = "^([a-zA-Z0-9]{6,20})$"
                
                let predict = NSPredicate(format:"SELF MATCHES %@", regex)
                isPassed = predict.evaluate(with: self.textField.text)
            }
            else if dataType == DataType.mobile{
                //version 1
                //                let regex = "^(((\\+44\\s?\\d{4}|\\(?0\\d{4}\\)?)\\s?\\d{3}\\s?\\d{3})|((\\+44\\s?\\d{3}|\\(?0\\d{3}\\)?)\\s?\\d{3}\\s?\\d{4})|((\\+44\\s?\\d{2}|\\(?0\\d{2}\\)?)\\s?\\d{4}\\s?\\d{4}))(\\s?\\#(\\d{4}|\\d{3}))?$"
                
                //version 2
                //                let regex = "^(07[\\d]{8,12}|447[\\d]{7,11})$"
                
                //version 3
                let regex = "((0|44|\\+44|\\+44\\s*\\(0\\)|\\+44\\s*0)\\s*)?7(\\s*[0-9]){9}"
                
                let predict = NSPredicate(format:"SELF MATCHES %@", regex)
                isPassed = predict.evaluate(with: self.textField.text)
            }else if dataType == DataType.number || dataType == DataType.currency{
                if (Double(self.textField.text!) == nil){
                    isPassed = false
                }
            }
            
            if extendedValidationType != .none{
                if extendedValidationType == ExtendedValidationType.inBetweenRange{
                    let value = Int(self.textField.text ?? "0") ?? 0
                    if(value < self.extendedValidationStart! || value > self.extendedValidationEnd!){
                        isPassed = false
                    }
                }else if (extendedValidationType == ExtendedValidationType.inBetweenLength){
                    let count = self.textField.text!.count
                    if(count < self.extendedValidationStart! || count > self.extendedValidationEnd!){
                        isPassed = false
                    }
                }
            }
        }
        
        if isPassed == false { displayTooltip() }
        return isPassed
    }
    
    func hideTooltipAndWarningIfVisible(){
        if (dataType != .password){
            toolTipView?.dismiss()
            accessoryButton.isHidden = true
            isErrorRevealed = false
        }
    }
    
    func setDisabled(){
        textField.isUserInteractionEnabled = false
        textField.backgroundColor = .color(fromHexString: "efefef")
    }
}

extension SmartTextField: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        //        (textField as? ErrorTextField)?.isErrorRevealed = false
        
        textFieldDidChange(textField.text ?? "")
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (extendedValidationType == ExtendedValidationType.inBetweenLength){
            let currentCharacterCount = textField.text?.count ?? 0
            if range.length + range.location > currentCharacterCount {
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= extendedValidationEnd ?? 0
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if (isErrorRevealed){
            toolTipView?.dismiss()
            accessoryButton.isHidden = true
            isErrorRevealed = false
            if (dataType == .password){
                if (textField.isSecureTextEntry == true){
                    accessoryButton.setImage(UIImage.init(named: "ic_hide_password"), for: .normal)
                }else{
                    accessoryButton.setImage(UIImage.init(named: "ic_show_password"), for: .normal)
                }
                accessoryButton.removeTarget(self, action: #selector(toggleTooltipState), for: .touchUpInside)
                accessoryButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
                accessoryButton.isHidden = false
            }
        }else{
            if (dataType == .password){
                if (textField.isSecureTextEntry == true){
                    accessoryButton.setImage(UIImage.init(named: "ic_hide_password"), for: .normal)
                }else{
                    accessoryButton.setImage(UIImage.init(named: "ic_show_password"), for: .normal)
                }
                accessoryButton.removeTarget(self, action: #selector(toggleTooltipState), for: .touchUpInside)
                accessoryButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
                accessoryButton.isHidden = false
            }
        }
    }
}

extension SmartTextField: EasyTipViewDelegate{
    public func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        isErrorRevealed = false
    }
}
