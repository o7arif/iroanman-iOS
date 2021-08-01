//
//  LegacySegmentedControl.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 8/1/21.
//

import UIKit

class LegacySegmentedControl: UISegmentedControl {
    private func stylize() {
        if #available(iOS 13.0, *) {
            tintColor = UIColor.color(fromHexString: "1DC1FF")
            selectedSegmentTintColor = tintColor
            backgroundColor = .white
            
            let tintColorImage = UIImage(color: tintColor)
            setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage(color: tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            
            setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            
            layer.cornerRadius = 0
            layer.masksToBounds = false
            
            // disabled text color
            setTitleTextAttributes([.foregroundColor: UIColor.color(fromHexString: "788493"), NSAttributedString.Key.font: OpenSans.regular.of(size: 20)], for: .normal)
            
            
            if let background = backgroundColor {
                // enabled text color
                self.setTitleTextAttributes([.foregroundColor: background, NSAttributedString.Key.font: OpenSans.bold.of(size: 20)], for: .selected)
            } else {
                func detectBackgroundColor(of view: UIView?) -> UIColor? {
                    guard let view = view else {
                        return nil
                    }
                    if let color = view.backgroundColor, color != .clear {
                        return color
                    }
                    return detectBackgroundColor(of: view.superview)
                }
                // enabled text color
                self.setTitleTextAttributes([.foregroundColor: UIColor.white, NSAttributedString.Key.font: OpenSans.bold.of(size: 20)], for: .selected)
            }
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        stylize()
    }
}

fileprivate extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
