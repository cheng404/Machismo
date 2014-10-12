//
//  ViewController.swift
//  Machismo
//
//  Created by Cheng Wei on 14/8/25.
//  Copyright (c) 2014年 github.com/cheng404. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLable: UILabel!
    
    @IBOutlet var cardViews: [PlayCardView]!
    
    lazy private(set) var deck = Deck()
    lazy private(set) var game: CardMatchingGame = {
        return CardMatchingGame(cardsCount: self.cardViews.count, usingDeck: self.deck)
    }()
    
    lazy private(set) var gameInvoker: () -> CardMatchingGame = {
        [unowned self] in
        return CardMatchingGame(cardsCount: self.cardViews.count, usingDeck: self.deck)
    }
    
    //lazy var game: CardMatchingGame = self.createGame()
    
//    func createGame() -> CardMatchingGame {
//        return CardMatchingGame(cardsCount: self.cardButtons.count, usingDeck: self.deck)
//    }

    
//    var _game: CardMatchingGame?
//    var game: CardMatchingGame {
//        get {
//            if _game == nil {
//                _game = CardMatchingGame(cardsCount: self.cardButtons.count, usingDeck: deck)
//            }
//            return _game!
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCardViews()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cardTouchAction(sender: PlayCardView) {
        var cardView = sender
        var chosenIndex = indexOfCardViews(cardView)
        //var card = game.cardAtIndex(chosenIndex)
        game.chooseCardAtIndex(chosenIndex)
        cardView.faceUp = !cardView.faceUp
        updateUI()
        print("\(cardView.card?.description())")
    }
    
    @IBAction func restartGameTouched(sender: AnyObject) {
        game = CardMatchingGame(cardsCount: self.cardViews.count, usingDeck: Deck())
        initCardViews()
        updateUI()
    }
    
    private func initCardViews() {
        for (index, cardView) in enumerate(cardViews) {
            var card = game.cardAtIndex(index)
            cardView.card = card
            cardView.faceUp = false
            cardView.enabled = true
        }
    }
    
    private func updateUI() {
        for cardView in cardViews.filter({ $0.enabled && $0.faceUp }) {
            var chosenIndex = indexOfCardViews(cardView)
            if let card = game.cardAtIndex(chosenIndex) {
                cardView.enabled = !card.isMatched
                cardView.faceUp = card.isChosen
            }
        }
        scoreLable.text = "Score: \(game.score)"
    }
    
    private func indexOfCardViews(card: PlayCardView) -> Int {
        for (index, _card) in enumerate(cardViews) {
            if card === _card {
                return index
            }
        }
        return -1
    }
    
}

