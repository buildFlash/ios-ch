//
//  TriangleView.swift
//  noloTest
//
//  Created by Aryan Sharma on 27/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(red: 246.0/255.0,
                             green: 244.0/255.0,
                             blue: 241.0/255.0,
                             alpha: 1.0)
        context.fillPath()
    }
}

