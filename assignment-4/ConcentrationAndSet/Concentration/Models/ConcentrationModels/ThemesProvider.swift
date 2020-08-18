//
//  Theme.swift
//  Concentration
//
//  Created by Kaloyan Simeonov on 24.04.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation
import UIKit

struct ThemesProvider {
    private(set) var themes: [Theme] = [
        Theme(name: "Halloween", emojiElements: ["🦇", "😱", "😈", "🎃", "👻", "🍭", "🍬", "🍎"], cardsColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        Theme(name: "Faces", emojiElements: ["🤨", "🤩", "😎", "🤬", "🤯", "🥳", "🤑", "😷"], cardsColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) , backgroundColor: #colorLiteral(red: 0.2077311277, green: 0.712641418, blue: 0.09412889928, alpha: 1)),
        Theme(name: "Animals", emojiElements: ["🐶", "🐼", "🐧", "🐒", "🦋", "🐡", "🦖", "🦁"], cardsColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) , backgroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),
        Theme(name: "Sports", emojiElements: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏏"], cardsColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1) , backgroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        Theme(name: "Food", emojiElements: ["🍗", "🍖", "🌭", "🍔", "🍟", "🍕", "🌯", "🍤"], cardsColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) , backgroundColor: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)),
        Theme(name: "Technology", emojiElements: ["📱", "💻", "📸", "🎥", "📼", "📻", "📺", "⌚️"], cardsColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , backgroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) )]

    func getTheme(name: String) -> Theme {
        switch name {
        case "Halloween":
            return themes[0]
        case "Faces":
            return themes[1]
        case "Animals":
            return themes[2]
        case "Sports":
            return themes[3]
        case "Food":
            return themes[4]
        case "Technology":
            return themes[5]
        default:
            return themes.randomElement()!
        }
    }
    lazy var emojiChoices: [String] = themes.randomElement()!.emojiElements
    
    private var emoji: [ConcentrationCard : String] = [:]
    
    mutating func emoji(for card: ConcentrationCard) -> String {
        if emoji[card] == nil, !emojiChoices.isEmpty {
            emoji[card] = emojiChoices.remove(at: emojiChoices.indices.randomElement()!)
        }
        return emoji[card] ?? "?"
    }
}








