//
//  NeuView+Ext.swift
//  Game-Of-Life
//
//  Created by Michael McGrath on 6/25/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import Foundation
import EMTNeumorphicView
import CoreGraphics

extension EMTNeumorphicView {
    
    func configureView(depth: CGFloat?, lightShadowColor: CGColor?, backgroundColor: CGColor?, lightOpacity: Float?, darkOpacity: Float?) {
        
        if let depth = depth {
            neumorphicLayer?.elementDepth = depth
        }
        
        if let lightShadowColor = lightShadowColor {
            neumorphicLayer?.elementColor = lightShadowColor
        }
        
        if let backgroundColor = backgroundColor {
            neumorphicLayer?.elementBackgroundColor = backgroundColor
        }
        
        if let lightOpacity = lightOpacity {
            neumorphicLayer?.lightShadowOpacity = lightOpacity
        }
        
        if let darkOpacity = darkOpacity {
            neumorphicLayer?.darkShadowOpacity = darkOpacity
        }
    }
    
}
