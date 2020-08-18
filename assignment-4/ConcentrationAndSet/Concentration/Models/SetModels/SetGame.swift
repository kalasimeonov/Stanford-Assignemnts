//
//  SetGame.swift
//  Set
//
//  Created by Kaloyan Simeonov on 30.04.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation
import UIKit

struct SetGame {
    
    var deck: Deck = Deck()
    
    private var selectedCards: [SetCard] = []
    
    private(set) var selectedIndices: [Int] = []
    
    private(set) var availableSetsIndices: [[Int]] = []
    
    private(set) var gameScore: Int = 0
    
    private(set) var isDrawButtonEnabled: Bool = true
    
    var willRemoveCells: Bool = false
    
    mutating func tapCard(at index: Int) {
        assert(deck.drawnCards.indices.contains(index), "SetGame.chooseCard(at: \(index)): chosen index not in the cards")
        let isCardAlreadySelected = selectedCards.contains(deck.drawnCards[index])
        if !isCardAlreadySelected {
            
            if selectedCards.count < 3 {
                selectCard(at: index)
            }
            
            if selectedCards.count == 3 {
                let isSet: Bool = isASet(cardOne: selectedCards[0], cardTwo: selectedCards[1], cardThree: selectedCards[2])
                if isSet {
                    gameScore += 5
                    removeCardsWhenSet()
                    cleanData()
                    
                    if numberOfVisibleCards() < 12 {
                        drawThreeMore()
                    } else {
                        willRemoveCells = true
                    }
                }
                if !isSet {
                    gameScore -= 3
                    deselectWrongSet()
                    cleanData()
                }
            }
        } else {
            deselectCards()
        }
        isDrawButtonEnabled = !deck.allCards.isEmpty
    }
    
    mutating func drawThreeMore() {
        isDrawButtonEnabled = !deck.allCards.isEmpty
        
        guard !deck.allCards.isEmpty else { return }
        
        gameScore -= !availableSetsIndices.isEmpty ? 3 : 0
        
        var visibleCards: Int = numberOfVisibleCards()
        var drawnCards = 0
        for _ in deck.drawnCards.indices {
            if drawnCards < 3 {
                let randomIndex = deck.allCards.indices.randomElement()!
                deck.drawnCards.append(deck.allCards.remove(at: randomIndex))
                visibleCards += 1
                drawnCards += 1
            }
        }
        isDrawButtonEnabled = visibleCards < 81
    }
    
    private func numberOfVisibleCards() -> Int {
        return deck.drawnCards.filter { $0.isVisible }.count
    }
    
    private mutating func cleanData() {
        selectedCards.removeAll()
        selectedIndices.removeAll()
    }
    
    mutating func writeSets() {
        availableSetsIndices.removeAll()
        for indexOne in deck.drawnCards.indices where indexOne < (deck.drawnCards.count - 3) {
            let cardOne = deck.drawnCards[indexOne]
            for indexTwo in deck.drawnCards.indices where indexTwo > indexOne {
                let cardTwo = deck.drawnCards[indexTwo]
                for indexThree in deck.drawnCards.indices where indexThree > indexTwo {
                    let cardThree = deck.drawnCards[indexThree]
                    if indexOne != indexTwo && indexTwo != indexThree && indexThree != indexOne,
                        cardOne.isVisible, cardTwo.isVisible, cardThree.isVisible,
                        isASet(cardOne: cardOne, cardTwo: cardTwo, cardThree: cardThree) {
                        availableSetsIndices.append([indexOne,indexTwo,indexThree])
                    }
                }
            }
        }
    }
    
}

// MARK: Extension for methods regarding tap of cards and their removal/deselection/selection.
private extension SetGame {
    
    mutating func selectCard(at index: Int) {
        deck.drawnCards[index].isSelected = true
        selectedCards.append(deck.drawnCards[index])
        selectedIndices.append(index)
    }
    
    mutating func removeCardsWhenSet() {
        for index in selectedIndices {
            if !deck.allCards.isEmpty {
                deck.replaceMatchedCard(at: index)
            } else {
                deck.drawnCards[index].isVisible = false
            }
        }
    }
    
    mutating func deselectWrongSet() {
        for index in selectedIndices {
            deck.drawnCards[index].isSelected = false
        }
    }
    
    mutating func deselectCards() {
        if selectedCards.count < 3 {
            if selectedCards.count == 1 {
                deck.drawnCards[selectedIndices[0]].isSelected = false
                gameScore -= 1
            }
            if selectedCards.count == 2 {
                deck.drawnCards[selectedIndices[0]].isSelected = false
                deck.drawnCards[selectedIndices[1]].isSelected = false
                gameScore -= 2
            }
            cleanData()
        }
    }
}


private extension SetGame {
    
    // MARK: Check if selected cards are a set
    func isASet(cardOne: SetCard, cardTwo: SetCard, cardThree: SetCard) -> Bool {
        guard (cardOne != cardTwo && cardTwo != cardThree && cardThree != cardOne) else { return false }
        
        func isValid<T:Equatable>(propertyOne: T, propertyTwo: T, propertyThree: T) -> Bool {
            return propertyOne == propertyTwo &&
                propertyTwo == propertyThree ||
                propertyOne != propertyTwo &&
                propertyTwo != propertyThree &&
                propertyThree != propertyOne
        }
        
        var isNumberOfShapesValid: Bool {
            return isValid(propertyOne: cardOne.numberOfShapes, propertyTwo: cardTwo.numberOfShapes, propertyThree: cardThree.numberOfShapes)
        }
        
        var isShapeValid: Bool {
            return isValid(propertyOne: cardOne.shape, propertyTwo: cardTwo.shape, propertyThree: cardThree.shape)
        }
        
        var isShadingValid: Bool {
            return isValid(propertyOne: cardOne.shading, propertyTwo: cardTwo.shading, propertyThree: cardThree.shading)
        }
        
        var isColorValid: Bool {
            return isValid(propertyOne: cardOne.color, propertyTwo: cardTwo.color, propertyThree: cardThree.color)
        }
        
        if isColorValid, isShadingValid, isShapeValid, isNumberOfShapesValid {
            return true
        } else {
            return false
        }
    }
}
