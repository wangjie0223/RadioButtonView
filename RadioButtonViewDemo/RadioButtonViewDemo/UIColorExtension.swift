//
//  Untitled.swift
//  RadioButtonViewDemo
//
//  Created by 王杰 on 2024/12/31.
//
import UIKit

extension UIColor {
    
    convenience init(r: UInt32 ,g: UInt32, b: UInt32 ,alpha: CGFloat = 1.0){
        self.init(red: CGFloat(r) / 255,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: alpha)
    }
    
    /// rgb(60,152,251)
    class var themeColor: UIColor { UIColor.init(r: 60, g: 152, b: 251) }
    
    
    // 颜色比较深
    class var color064064064a1: UIColor { UIColor.init(r: 64, g: 64, b: 64) }
    
    class var color237237237a1: UIColor { UIColor.init(r: 237, g: 237, b: 237) }
}
