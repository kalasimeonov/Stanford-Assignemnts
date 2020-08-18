//
//  SquiggleView.swift
//  Set
//
//  Created by Kaloyan Simeonov on 14.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class SquiggleView: UIView, SetFigureDrawable {
    
    var color: UIColor = UIColor.clear
    
    var shading: String = ""
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let squiggle = UIBezierPath()
        squiggle.move(to: CGPoint(x: (rect.midX / 3), y: (rect.maxY / 3)))
        squiggle.addCurve(to: CGPoint(x: (rect.maxX * 0.8333), y: (rect.maxY / 3)), controlPoint1: CGPoint(x: (rect.maxX / 3), y: (rect.midY * 0.3066)), controlPoint2: CGPoint(x: (rect.maxX * 0.59333), y: (rect.maxY * 0.59333)))
        squiggle.addCurve(to: CGPoint(x: (rect.maxX * 0.75), y: (rect.maxY * 0.666)), controlPoint1: CGPoint(x: rect.maxX, y: (rect.midY * 0.4)), controlPoint2: CGPoint(x: rect.maxX, y: (rect.maxY * 0.64)))
        squiggle.addCurve(to: CGPoint(x: (rect.maxX / 3), y: (rect.maxY * 0.5866)), controlPoint1: CGPoint(x: (rect.maxX * 0.56), y: (rect.maxY * 0.6933)), controlPoint2: CGPoint(x: (rect.midX * 0.8533), y: (rect.maxY * 0.5666)))
        squiggle.addCurve(to: CGPoint(x: (rect.midX / 3), y: (rect.maxY * 0.666)), controlPoint1: CGPoint(x: (rect.midX * 0.4533), y: (rect.maxY * 0.6)), controlPoint2: CGPoint(x: (rect.midX * 0.4533), y: (rect.maxY * 0.666)))
        squiggle.addCurve(to: CGPoint(x: (rect.midX / 3), y: (rect.maxY / 3)), controlPoint1: CGPoint(x: (rect.midX * 0.16), y: (rect.maxY * 0.64)), controlPoint2: CGPoint(x: (rect.midX * 0.08), y: (rect.midY * 0.8933)))
        color.setStroke()
        color.setFill()
        squiggle.lineWidth = 3
        squiggle.addClip()
        squiggle.move(to: CGPoint(x: 0,y: 0))
        if shading == "striped" {
            addShading(to: squiggle, in: rect)
        }
        if shading == "solid" {
            squiggle.fill()
        }
        backgroundColor = UIColor.white
        squiggle.stroke()
        
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

extension UIView {
    
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
    }
    
}
