//
//  Theme.swift
//  Concentration
//
//  Created by Kaloyan Simeonov on 4.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    private(set) var name: String
    
    private(set) var emojiElements: [String]
    
    private(set) var backgroundColor: UIColor
    
    private(set) var cardsColor: UIColor
    
    init(name: String, emojiElements: [String], cardsColor: UIColor, backgroundColor: UIColor) {
        self.name = name
        self.emojiElements = emojiElements
        self.backgroundColor = backgroundColor
        self.cardsColor = cardsColor
    }
    
}
