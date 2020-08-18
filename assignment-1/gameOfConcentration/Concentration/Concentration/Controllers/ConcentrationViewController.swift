//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Kaloyan Simeonov on 22.04.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfCardPairs: numberOfCardPairs)
    private lazy var themes = ThemesProvider()
    
    @IBOutlet private weak var scoreCountLabel: UILabel! {
        didSet {
            update(label: scoreCountLabel, labelText: "Score: \(game.scoreCount)")
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            update(label: flipCountLabel, labelText: "Flips: \(game.flipCount)")
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var numberOfCardPairs: Int {
        return (cardButtons.count + 1) / 2
    }
    
}

private extension ConcentrationViewController {
    
    
    func update(label: UILabel, labelText: String) {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : themes.theme.cardsColor  ]
        let attributedString = NSAttributedString(string: labelText, attributes: attributes)
        label.attributedText = attributedString
    }
    
    func updateViewFromModel() {
        update(label: flipCountLabel, labelText: "Flips: \(game.flipCount)")
        update(label: scoreCountLabel, labelText: "Score: \(game.scoreCount)")
        view.backgroundColor = themes.theme.backgroundColor
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(themes.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : themes.theme.cardsColor
                button.isEnabled = !card.isMatched
                
            }
        }
    }
}

private extension ConcentrationViewController {
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        themes = ThemesProvider()
        game = Concentration(numberOfCardPairs: numberOfCardPairs)
        sender.setTitleColor(themes.theme.cardsColor, for: .normal)
        for button in cardButtons {
            button.isEnabled = true
        }
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {
            fatalError("chosen card was not in cardButtons")
        }
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
}
