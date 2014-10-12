//
//  CardMatchGame.swift
//  Machismo
//
//  Created by Cheng Wei on 14/8/25.
//  Copyright (c) 2014年 github.com/cheng404. All rights reserved.
//

import Foundation

class CardMatchingGame {
    
    private var cards: [Card] = [Card]()
    private let match_bouns = 4
    private let mismatch_penalty = 2
    private let cost_to_choose = 1
    private(set) var score = 0
    
    init(cardsCount: Int, usingDeck: Deck){
        for i in 0 ..< cardsCount {
            if let card = usingDeck.drawRandomCard() {
                cards.append(card)
            }
            else {
                break
            }
        }
    }

    func cardAtIndex(index: Int) -> Card? {
        return index < cards.count ? cards[index] : nil
    }
    
    func chooseCardAtIndex(index: Int) {
        if let card = cardAtIndex(index) {
            if !card.isMatched {
                if card.isChosen {
                    card.isChosen = false
                } else {
                    for otherCard in cards {
                        if !otherCard.isMatched && otherCard.isChosen {
                            matchCards(card, otherCard: otherCard)
                            break
                        }
                    }
                    score -= cost_to_choose
                    card.isChosen = true
                }
            }
        }
    }
    
    private func matchCards(card: Card, otherCard: Card) {
        var matchScore = card.match([otherCard])
        if matchScore != 0 {
            score += matchScore * match_bouns
            otherCard.isMatched = true
            card.isMatched = true
        }
        else {
            otherCard.isChosen = false
            score -= mismatch_penalty
        }
    }
    
}