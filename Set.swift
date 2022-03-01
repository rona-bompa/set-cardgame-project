//
//  Set.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 25.02.2022.
//

import Foundation

class Set {

    var deckCards = [Card]()
    var listOfCardsBeingPlayed = [Card]()
//    var selectedCards: [Card]
//    var matchedCards: [Card]

    init() {
        // init the deck of Cards
        for shape in Card.Shape.all {
            for color in Card.Color.all {
                for filling in Card.Filling.all {
                    for numberOfShapes in 1...3 {
                        deckCards.append(Card(shapes: shape, color: color, filling: filling, numberOfShapes: numberOfShapes))
                    }
                }
            }
        }
        deckCards.shuffle()  // shuffle

        // init the list of cards Being Played
        for index in 0...11 {
            listOfCardsBeingPlayed.append(deckCards[index])
            deckCards.remove(at: 0) // remove the element just added
        }
    }

    // functionality #1: selecting cards to match
    // logica jocului

    // functionality #2: dealing three new cards

}


