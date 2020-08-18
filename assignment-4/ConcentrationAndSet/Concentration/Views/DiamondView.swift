//
//  DiamondView.swift
//  Set
//
//  Created by Kaloyan Simeonov on 14.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class DiamondView: UIView, SetFigureDrawable {
    
    var color: UIColor = UIColor.clear
    
    var shading: String = ""
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let diamond = UIBezierPath()
        color.setStroke()
        diamond.move(to: CGPoint(x: 0, y: rect.midY))
        diamond.addLine(to: CGPoint(x: rect.midX, y: (rect.maxY * 0.75)))
        diamond.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        diamond.addLine(to: CGPoint(x: rect.midX, y: (rect.midY / 2)))
        diamond.close()
        diamond.addClip()
        diamond.lineWidth = 3
        if shading == "striped" {
            addShading(to: diamond, in: rect)
        }
        if shading == "solid" {
            color.setFill()
            diamond.fill()
        }
        backgroundColor = UIColor.white
        diamond.stroke()
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

