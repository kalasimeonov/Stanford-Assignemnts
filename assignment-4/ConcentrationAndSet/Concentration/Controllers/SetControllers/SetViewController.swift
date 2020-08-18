//
//  SetViewController.swift
//  Set
//
//  Created by Kaloyan Simeonov on 30.04.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class SetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var scoreLabel: UINavigationItem! {
        didSet {
            updateScore()
        }
    }
    
    private lazy var selectedIndexPaths = game.selectedIndices.map { IndexPath(item: $0, section: 1) }
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet{
            collectionLayout.minimumLineSpacing = 3.0
            collectionLayout.minimumInteritemSpacing = 3.0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.deck.drawnCards.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        
        newCell.configureCell(withCard: game.deck.drawnCards[indexPath.item], at: indexPath.item)
        
        return newCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game.tapCard(at: indexPath.item)
        if game.willRemoveCells == true {
            cardsCollectionView.performBatchUpdates({
                cardsCollectionView.deleteItems(at: selectedIndexPaths)
            }) { (finished) in
                self.updateBorders()
            }
            cardsCollectionView.reloadSections([0])
            updateViewFromModel()
        }
        updateViewFromModel()
        game.willRemoveCells = false
    }
    
    private(set) lazy var collectionViewCells: [CardCell] = cardsCollectionView.visibleCells.map { $0 as! CardCell }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        
        let rotationGesture =  UIRotationGestureRecognizer(target: self, action: #selector(shuffleGesture(_:)))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dealMoreCardsGesture(_:)))
        
        swipeGesture.direction = .down
        swipeGesture.numberOfTouchesRequired = 1
        
        cardsCollectionView.addGestureRecognizer(swipeGesture)
        cardsCollectionView.addGestureRecognizer(rotationGesture)
    }
    
    private(set) var game = SetGame()
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!  {
        didSet {
            cardsCollectionView.isUserInteractionEnabled = true
            cardsCollectionView.isMultipleTouchEnabled = true
        }
    }
    
    // MARK: The deal 3 more cards button itself.
    @IBOutlet private var dealMoreCardsButton: UIButton! {
        didSet{
            dealMoreCardsButton.layer.cornerRadius = 7
        }
    }
    
    // MARK: The Restart button itself.
    @IBOutlet private weak var restartButton: UIButton! {
        didSet{
            restartButton.layer.cornerRadius = 7
        }
    }
    
    // MARK: Button for cheating
    @IBOutlet weak var cheatButton: UIButton! {
        didSet{
            cheatButton.layer.cornerRadius = 7
        }
    }
    
    // MARK: Action of when Deal 3 more cards button is pressed.
    @IBAction private func dealMoreCards(_ sender: UIButton) {
        drawCards()
    }
    
    // MARK: Action for pressing of Restart button
    @IBAction private func restartButtonPressed(_ sender: UIButton) {
        game = SetGame()
        cardsCollectionView.reloadSections([0])
        updateViewFromModel()
    }
    
    //MARK: When cheat button is pressed - Action
    @IBAction func cheatButtonPressed(_ sender: UIButton) {
        game.writeSets()
        guard !game.availableSetsIndices.isEmpty else {
            cheatButton.shake()
            return
        }
        for index in game.availableSetsIndices[0] {
            game.deck.drawnCards[index].isSelected = true
        }
        updateViewFromModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !self.game.availableSetsIndices.isEmpty {
                for index in self.game.availableSetsIndices[0] {
                    self.game.deck.drawnCards[index].isSelected = false
                }
            }
            self.updateViewFromModel()
        }
    }
    
    @objc func dealMoreCardsGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            drawCards()
        }
    }
    
    @objc func shuffleGesture(_ gesture: UIRotationGestureRecognizer) {
        if gesture.state == .ended {
            game.deck.drawnCards.shuffle()
            cardsCollectionView.performBatchUpdates({
                cardsCollectionView.reloadSections([0])
            }) { (finished) in
                self.cardsCollectionView.reloadSections([0])
            }
            updateViewFromModel()
            
        }
    }
    
    func drawCards() {
        game.drawThreeMore()
        let firstNewIndex = game.deck.drawnCards.count - 4
        let lastNewIndex = game.deck.drawnCards.count - 1
        let indexPaths = Array((firstNewIndex)...(lastNewIndex)).map { IndexPath(item: $0, section: 0) }
        cardsCollectionView.performBatchUpdates({
            cardsCollectionView.insertItems(at: indexPaths)
        }) { (finished) in
            self.updateViewFromModel() }
    }
    
}

extension SetViewController: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var factor: Float = 0.5
        switch game.deck.drawnCards.count {
        case 27..<40:
            factor = 0.7
        case 40..<66:
            factor = 1
        case 66..<82:
            factor = 2
        default:
            factor = 0.5
        }
        
        
        let height = CGFloat(60 / factor)
        let width = height * (2 / 3)
        let size = CGSize(width: width, height: height)
        return size
    }
}

private extension SetViewController {
    
    func updateScore() {
        scoreLabel?.title = "Score: \(game.gameScore)"
    }
    
    func updateBorders() {
        collectionViewCells = cardsCollectionView.visibleCells.map { $0 as! CardCell }
        collectionViewCells.forEach {
            let isSelected = game.deck.drawnCards[$0.indexOfSelectedCard].isSelected
            $0.layer.borderWidth = isSelected ? 3.0 : 0.0
        }
    }
    
    func updateViewFromModel() {
        updateScore()
        updateBorders()
        dealMoreCardsButton?.isEnabled = game.isDrawButtonEnabled
    }
    
}


