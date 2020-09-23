//
//  utils.swift
//  kindle-app
//
//  Created by Andrews Frempong on 22/09/2020.
//  Copyright © 2020 Andrews Frempong. All rights reserved.
//

import UIKit

extension UIView{
    
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingRight: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let width = width{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    func centerX(inView view: UIView, constant: CGFloat) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    
    func centerY(inView view: UIView, constant: CGFloat) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
}

extension UIColor{
    static func rgbValues(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
