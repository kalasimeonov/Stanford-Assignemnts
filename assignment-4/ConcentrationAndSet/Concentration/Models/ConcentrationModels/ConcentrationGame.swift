//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Kaloyan Simeonov on 22.04.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards: [ConcentrationCard] = []
    
    private(set) var scoreCount = 0
    
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isFaceUp {
            flipCount += 1
        }
        guard !cards[index].isMatched else { return }
        guard let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index else {
            indexOfOneAndOnlyFaceUpCard = index
            return
        }
        let firstCard = cards[matchIndex]
        let secondCard = cards[index]
        // check if hards match
        if firstCard == secondCard {
            
            cards[matchIndex].isMatched = true
            cards[index].isMatched = true
            scoreCount += 2
        }
        else {
            // if they dont match
            if secondCard.wasFlipped && !firstCard.wasFlipped {
                scoreCount -= 1
            }
            if !secondCard.wasFlipped && firstCard.wasFlipped {
                scoreCount -= 1
            }
            // and both were already seen
            if secondCard.wasFlipped && firstCard.wasFlipped {
                scoreCount -= 2
            }
            cards[index].wasFlipped = true
            cards[matchIndex].wasFlipped = true
        }
        cards[index].isFaceUp = true
        cards[matchIndex].isFaceUp = true
    }
    
    
    
    init(numberOfCardPairs: Int) {
        assert(numberOfCardPairs > 0, "Concentration.init (\(numberOfCardPairs)): you must have at least one pair of cards")
        for _ in 1...numberOfCardPairs {
            let card = ConcentrationCard()
            cards += [card, card]
            
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}


