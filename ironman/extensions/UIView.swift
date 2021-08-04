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
