//
//  UIView+GradientLayer.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/24/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import UIKit

extension UIView {
    func addGradient(color1: UIColor, color2: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor]
        gradientlayer.locations = [0.0, 1.0]
        gradientlayer.frame = bounds
        gradientlayer.masksToBounds = true
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientlayer, at: 0)
    }
    
    func addGradient2(color1: UIColor, color2: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor]
        gradientlayer.locations = [0.0, 1.0]
        gradientlayer.frame = bounds
        gradientlayer.masksToBounds = true
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientlayer, at: 0)
    }
}
