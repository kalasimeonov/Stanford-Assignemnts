//
//  CardCell.swift
//  Set
//
//  Created by Kaloyan Simeonov on 15.05.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private(set) var indexOfSelectedCard: Int = 0
    
    private(set) var shapesColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    private(set) var numberOfShapes: Int = 0
    
    private(set) var shading: String = ""
    
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 7.0
    }
    
    func configureCell(withCard card: SetCard, at index: Int) {
    
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        indexOfSelectedCard = index
        
        switch card.color {
        case .red:
            shapesColor = UIColor.red
        case .purple:
            shapesColor = UIColor.purple
        case .green:
            shapesColor = UIColor.green
        }
        
        switch card.shading {
        case .solid:
            shading = "solid"
        case .striped:
            shading = "striped"
        case .empty:
            shading = "empty"
        }
        
        switch card.numberOfShapes {
        case .one:
            numberOfShapes = 1
        case .two:
            numberOfShapes = 2
        case .three:
            numberOfShapes = 3
        }
        
        let figureFrame = CGRect(x: 0, y: 0, width: (frame.width / 3), height: (frame.height / 3))
        switch card.shape {
        case .squiggle:
            for _ in 1...numberOfShapes {
                let createdFigure = SquiggleView(frame: figureFrame)
                stackView.addArrangedSubview(createdFigure)

            }
        case .diamond:
            for _ in 1...numberOfShapes {
                let createdFigure = DiamondView(frame: figureFrame)
                stackView.addArrangedSubview(createdFigure)
            }
        case .oval:
            for _ in 1...numberOfShapes {
                let createdFigure = OvalView(frame: figureFrame)
                stackView.addArrangedSubview(createdFigure)
            }
        }
        
        stackView.arrangedSubviews.forEach { view in
            guard let figureView = view as? SetFigureDrawable else {
                return
            }
            figureView.backgroundColor = UIColor.white
            figureView.color = shapesColor
            figureView.shading = shading
        }
    }
}
