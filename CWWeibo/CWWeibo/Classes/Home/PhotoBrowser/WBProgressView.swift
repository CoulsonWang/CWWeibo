//
//  WBProgressView.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/9.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBProgressView: UIView {
    
    var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let arcCenter = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let radius = rect.width * 0.5 - 5
        let startAngle = CGFloat(-Double.pi * 0.5)
        let endAngle = CGFloat(Double.pi * 2) * progress + startAngle
        
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addLine(to: arcCenter)
        
        UIColor(white: 1, alpha: 1).setFill()
        
        path.fill()
        
    }


}
