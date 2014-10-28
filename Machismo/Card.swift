//
//  Card.swift
//  Machismo
//
//  Created by Cheng Wei on 14/8/25.
//  Copyright (c) 2014年 github.com/cheng404. All rights reserved.
//

import Foundation
import UIKit

typealias Suit = Card.Suit
typealias Rank = Card.Rank

class Card {
    
    var rank: Rank
    var suit: Suit
    
    var isChosen: Bool = false
    var isMatched: Bool = false
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    func match(otherCards: [Card]) -> Int {
        var score = 0;
        for otherCard in otherCards {
            if otherCard.rank == rank {
                score += 4
            }
            else if otherCard.suit == suit {
                score += 1
            }
        }
        return score
    }
    
    func description() -> String {
        return suit.description() + rank.description()
    }
    
    func colorOfSuit() -> UIColor {
        switch self.suit {
        case .Diamonds, .Hearts:
            return UIColor(red: 225/255, green: 0/255, blue: 42/255, alpha: 1)
        default:
            return UIColor.blackColor()
        }
    }
    
    enum Rank: Int {
        case Ace = 1
        case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King
        
        func description() -> String {
            switch self {
            case .Ace: return "A"
            case .Jack: return "J"
            case .Queen: return "Q"
            case .King: return "K"
            default:
                return String(self.rawValue)
            }
        }
    }
    
    enum Suit {
        case Spades, Hearts, Clubs, Diamonds
        
        func description() -> String {
            switch self {
            case .Spades:
                return "♠︎"
            case .Hearts:
                return "♥︎"
            case .Clubs:
                return "♣︎"
            case .Diamonds:
                return "♦︎"
            }
        }
    }
}