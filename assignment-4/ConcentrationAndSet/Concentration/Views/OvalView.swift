//
//  OvalView.swift
//  Set
//
//  Created by Kaloyan Simeonov on 14.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class OvalView: UIView, SetFigureDrawable {
    
    var color: UIColor = UIColor.clear
    
    var shading: String = ""
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let oval = UIBezierPath(roundedRect: CGRect(x: rect.midX / 4, y: rect.midY / 2, width: rect.width * 0.8, height: rect.height / 2), cornerRadius: 20.0)
        
        color.setStroke()
        oval.lineWidth = 3
        if shading == "striped" {
            oval.addClip()
            addShading(to: oval, in: rect)
        }
        if shading == "solid" {
            color.setFill()
            oval.fill()
        }
        backgroundColor = UIColor.white
        oval.stroke()
    }
    
    func addShading(to shape: UIBezierPath, in rect: CGRect) {
        var coordinates: CGFloat = 0.0
        while coordinates < rect.maxX {
            shape.lineWidth = 0.8
            shape.addLine(to: CGPoint(x: coordinates, y: rect.minY))
            coordinates += (rect.width * 0.05)
            shape.move(to: CGPoint(x: coordinates, y: rect.minY))
            shape.addLine(to: CGPoint(x: coordinates, y: rect.maxY))
            coordinates += (rect.width * 0.05)
            shape.move(to: CGPoint(x: coordinates, y: rect.maxY))
        }
    }
}
