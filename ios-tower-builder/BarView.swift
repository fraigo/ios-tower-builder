//
//  BarView.swift
//  ios-tower-builder
//
//  Created by Francisco on 2018-10-03.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit


extension UIBezierPath {
    
    
    func moveTo(_ x : CGFloat, _ y: CGFloat){
        self.move(to: CGPoint(
            x: x,
            y: y))
    }
    
    func lineTo(_ x : CGFloat, _ y: CGFloat){
        self.addLine(to: CGPoint(
            x: x,
            y: y))
    }
    
}

@IBDesignable // To draw on InterfaceBuilder
class BarView: UIView {

    
    @IBInspectable // To show on InterfaceBuilder
    var type: Int = 0 {
        didSet {
            setNeedsDisplay() // To redraw when changes
            setNeedsLayout()  // For subviews
        }
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.green.setStroke()
        let path = UIBezierPath()
        path.moveTo(0,0)
        path.lineTo(rect.width, 0)
        path.lineTo(rect.width, rect.height)
        //path.lineTo(0, rect.height)
        path.lineTo(0, 0)
        path.stroke()
        
    }
    
    
    
  
    
}
