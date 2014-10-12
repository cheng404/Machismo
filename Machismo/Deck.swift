//
//  Deck.swift
//  Machismo
//
//  Created by Cheng Wei on 14/8/25.
//  Copyright (c) 2014年 github.com/cheng404. All rights reserved.
//

import Foundation

class Deck {
    
    private let suits = [Suit.Spades, Suit.Hearts, Suit.Clubs, Suit.Diamonds]
    private let ranks = [Rank.Ace, Rank.Two, Rank.Three, Rank.Four, Rank.Five, Rank.Six,
                            Rank.Seven, Rank.Eight, Rank.Nine, Rank.Ten, Rank.Jack, Rank.Queen, Rank.King]
    private var cards: [Card]!
    
    init() {
        cards = [Card]()
        // get 52 cards
        for suit in suits {
            for rank in ranks {
                cards.append(Card(suit: suit, rank: rank))
            }
        }
    }
    
    func addCard(card: Card, atTop: Bool) {
        if atTop {
            cards.insert(card, atIndex: 0)
        }
        else {
            cards.append(card)
        }
    }
    
    func addCard(card:Card) {
        return self.addCard(card, atTop:false)
    }
    
    func drawRandomCard() -> Card? {
        if cards.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            return cards.removeAtIndex(randomIndex)
        }
        return nil
    }
}