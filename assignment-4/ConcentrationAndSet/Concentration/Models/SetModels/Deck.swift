//
//  Deck.swift
//  Set
//
//  Created by Kaloyan Simeonov on 28.04.20.
//

import Foundation

struct Deck {
    
    var allCards: [SetCard] = []
    
    var drawnCards: [SetCard] = []
    
    init () {
        for shape in SetCard.Shape.allCases{
            for shading in SetCard.Shading.allCases {
                for color in SetCard.Color.allCases {
                    for number in SetCard.Number.allCases {
                        allCards.append(SetCard(numberOfShapes: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        allCards.shuffle()
        for index in 0...11 {
            var card = allCards.remove(at: index)
            card.isVisible = true
            drawnCards.append(card)
        }
    }
    
    mutating func replaceMatchedCard(at index: Int) {
        guard !allCards.isEmpty else { return }
        if let randomCardIndex = allCards.indices.randomElement() {
            let drawnCard = allCards.remove(at: randomCardIndex)
            drawnCards[index] = drawnCard
        }
    }
    
}

