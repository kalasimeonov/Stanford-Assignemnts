//
//  Card.swift
//  Set
//
//  Created by Kaloyan Simeonov on 29.04.20.
//

import Foundation

struct SetCard : Equatable {
    
    private(set) var numberOfShapes: Number
    
    private(set) var shape: Shape
    
    private(set) var shading: Shading
    
    private(set) var color: Color
    
    var isVisible: Bool = false
    var isSelected: Bool = false
    
    enum Number: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
        
        var numberDescription: Int { return rawValue }
    }
    
    enum Shape: String, CaseIterable {
        case diamond
        case squiggle
        case oval
        
        var shapeDescription: String { return rawValue }
    }
    
    enum Shading: String, CaseIterable {
        case solid
        case empty
        case striped
        
        var shadingDescription: String { return rawValue }
    }
    
    enum Color: String, CaseIterable {
        case red
        case green
        case purple

    }
    
}
