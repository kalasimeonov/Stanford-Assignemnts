//
//  SetFigureDrawable.swift
//  Set
//
//  Created by Kaloyan Simeonov on 20.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation
import UIKit

protocol SetFigureDrawable where Self: UIView {
    
    var color: UIColor { get set }
    
    var shading: String { get set }
    
    func addShading(to shape: UIBezierPath, in rect: CGRect)
}
