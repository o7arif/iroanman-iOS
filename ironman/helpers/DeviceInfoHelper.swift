//
//  DeviceInfoHelper.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/6/21.
//

import UIKit

enum DeviceType {
    case iPhone
    case iPad
    case unknown
}

enum DeviceName {
    case iPhone5_5C
    case iPhone6_7_8
    case iPhone6_7_8_Plus
    case iPhoneX_XS_11Pro
    case iPhoneXS_11Pro_Max
    case iPhoneXR_11
    case iPhone_unspecific
    case iPad_unspecific
    case unknown
}

struct ScaleFactorConfiguration {
    var iPhone5_5C: Double
    var iPhone6_7_8: Double
    var iPhone6_7_8_Plus: Double
    var iPhoneX_XS_11Pro: Double
    var iPhoneXS_11Pro_Max: Double
    var iPhoneXR_11: Double
    var iPhone_unspecific: Double
    var iPad_unspecific: Double
    
    init(iPhone5_5C: Double, iPhone6_7_8: Double, iPhone6_7_8_Plus: Double, iPhoneX_XS_11Pro: Double, iPhoneXS_11Pro_Max: Double, iPhoneXR_11: Double, iPhone_unspecific: Double, iPad_unspecific: Double) {
        self.iPhone5_5C = iPhone5_5C
        self.iPhone6_7_8 = iPhone6_7_8
        self.iPhone6_7_8_Plus = iPhone6_7_8_Plus
        self.iPhoneX_XS_11Pro = iPhoneX_XS_11Pro
        self.iPhoneXS_11Pro_Max = iPhoneXS_11Pro_Max
        self.iPhoneXR_11 = iPhoneXR_11
        self.iPhone_unspecific = iPhone_unspecific
        self.iPad_unspecific = iPad_unspecific
    }
}

enum ApplicationState {
//    case active
    case background
    case foreground
}

protocol ApplicationStateDelegate {
    func applicationStateChanged(state: ApplicationState)
}

class DeviceInfoHelper{
    
    static let instance = DeviceInfoHelper()
    
    var scale_factor_configuration: ScaleFactorConfiguration?
    var type: DeviceType
    var name: DeviceName
    var height: CGFloat
    var height_one_fourth: CGFloat
    var width: CGFloat
    var has_notch: Bool
    var safe_area_top: CGFloat
    var safe_area_top_with_statusbar: CGFloat
    var safe_area_bottom: CGFloat
    var application_state: ApplicationState
    var delegate: ApplicationStateDelegate?
    
    var keyWindow: UIWindow?
    
    fileprivate var scale_factor: Double?
    
    private init() {
        
        if #available(iOS 13.0, *) {
            keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        
        self.application_state = .foreground
        self.width = UIScreen.main.bounds.width
        self.height = UIScreen.main.bounds.height
        self.height_one_fourth = self.height / 4
        self.has_notch = (keyWindow?.safeAreaInsets.bottom ?? 0) > 0 ? true : false
        print("width:", self.width, "height:", self.height)
        
        //safe area top and bottom
        if #available(iOS 11.0, *) {
            self.safe_area_top = ((keyWindow?.safeAreaInsets.top)! - 20)
            self.safe_area_top_with_statusbar = (keyWindow?.safeAreaInsets.top)!
            self.safe_area_bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            self.safe_area_top = 0
            self.safe_area_bottom = 0
            self.safe_area_top_with_statusbar = 20
        }
        
        print("-top -topwithstatusbar - bottom -hasnotch", safe_area_top, safe_area_top_with_statusbar ,safe_area_bottom, self.has_notch)
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                self.name = .iPhone5_5C //print("iPhone 5 or 5S or 5C")
            case 1334:
                self.name = .iPhone6_7_8 //print("iPhone 6/6S/7/8")
            case 1920, 2208:
                self.name = .iPhone6_7_8_Plus //print("iPhone 6+/6S+/7+/8+")
            case 2436:
                self.name = .iPhoneX_XS_11Pro //print("iPhone X/XS/11 Pro")
            case 2688:
                self.name = .iPhoneXS_11Pro_Max //print("iPhone XS Max/11 Pro Max")
            case 1792:
                self.name = .iPhoneXR_11 //print("iPhone XR/ 11 ")
            default:
                self.name = .iPhone_unspecific //print("Unknown")
            }
            
            self.type = .iPhone
            
        } else if UIDevice().userInterfaceIdiom == .pad {
            self.type = .iPad
            self.name = .iPad_unspecific
        } else {
            self.type = .unknown
            self.name = .unknown
        }
    }
    
    func getScaleFactor() -> Double{
        if (self.scale_factor != nil) {
            return self.scale_factor!
        } else {
            self.setScaleFactor()
            return self.scale_factor!
        }
    }
    
    func getScaleFactorForDashingReferral() -> Double {
        if (name == .iPhone6_7_8) {
            return 0.55
        } else {
            return self.scale_factor ?? 1.0
        }
    }
    
    func setScaleFactor() {
        
        if (self.scale_factor_configuration != nil) {

            switch self.name {

            case .iPhone5_5C:
                self.scale_factor = self.scale_factor_configuration?.iPhone5_5C
            
            case .iPhone6_7_8:
                self.scale_factor = self.scale_factor_configuration?.iPhone6_7_8
            
            case .iPhone6_7_8_Plus:
                self.scale_factor = self.scale_factor_configuration?.iPhone6_7_8_Plus
            
            case .iPhoneX_XS_11Pro:
                self.scale_factor = self.scale_factor_configuration?.iPhoneX_XS_11Pro
            
            case .iPhoneXS_11Pro_Max:
                self.scale_factor = self.scale_factor_configuration?.iPhoneXS_11Pro_Max
            
            case .iPhoneXR_11:
                self.scale_factor = self.scale_factor_configuration?.iPhoneXR_11
                
            case .iPhone_unspecific:
                self.scale_factor = self.scale_factor_configuration?.iPhoneX_XS_11Pro
                
            case .iPad_unspecific:
                self.scale_factor = self.scale_factor_configuration?.iPad_unspecific
                
            case .unknown:
                self.scale_factor = self.scale_factor_configuration?.iPhoneX_XS_11Pro
                
            }
            
        } else {
            print("SCALE FACTOR CONFIGURATIONs ARE NOT SET. WE ARE SETTING DEFAULT CONFIGURATION")
            self.scale_factor_configuration = ScaleFactorConfiguration.init(iPhone5_5C: 0.6, iPhone6_7_8: 0.8, iPhone6_7_8_Plus: 1.2, iPhoneX_XS_11Pro: 1.0, iPhoneXS_11Pro_Max: 1.2, iPhoneXR_11: 1.0, iPhone_unspecific: 1.0, iPad_unspecific: 1.4)
            self.setScaleFactor()
        }
    }
}
