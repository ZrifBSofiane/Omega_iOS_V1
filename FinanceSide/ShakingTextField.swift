//
//  ShakingTextField.swift
//  FinanceSide
//
//  Created by Sofiane Bouragba Zrif  on 21/10/2017.
//  Copyright © 2017 Sofiane Bouragba Zrif . All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint : CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x  + 4, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.red.cgColor
        colorAnimation.toValue = UIColor.blue.cgColor
        colorAnimation.duration = 0.5
        self.layer.add(colorAnimation, forKey: "ColorPulse")
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
