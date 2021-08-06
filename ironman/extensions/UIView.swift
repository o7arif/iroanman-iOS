//
//  UIView.swift
//  ironman
//
//  Created by Shofikul Islam on 05/08/2021.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 10
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    func moveBarButton(color: UIColor, segmentdController: UISegmentedControl) {
        let x = (segmentdController.frame.width / CGFloat(segmentdController.numberOfSegments)) * CGFloat(segmentdController.selectedSegmentIndex)
        let width = segmentdController.frame.width / CGFloat(segmentdController.numberOfSegments)
        let y = segmentdController.frame.maxY
        self.translatesAutoresizingMaskIntoConstraints = true
        
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: x, y: y, width: width, height: self.frame.height)
        }
        
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = color
    }
    
    func moveView(_ view: UIView, duration: Double = 0.5, completion: ((Bool) -> Void)? = nil, toX: CGFloat) {
        view.transform = CGAffineTransform(translationX: view.frame.origin.x, y: 0.0)
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: { () -> Void in
                        view.transform = CGAffineTransform(translationX: toX, y: 0.0)
                       }, completion: completion)
    }
    
}
