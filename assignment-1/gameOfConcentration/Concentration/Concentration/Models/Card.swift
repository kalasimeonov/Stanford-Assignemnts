//
//  Card.swift
//  Concentration
//
//  Created by Kaloyan Simeonov on 22.04.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return identifier }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var wasFlipped = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func resetUniqueIdentifier () {
        identifierFactory = 0
    }
    
}
