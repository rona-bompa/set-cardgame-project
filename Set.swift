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
    var selectedCards = [Card]()
    var matchedCards = [Card]()

    init() {
        newGame()
    }

    func newGame() {
        deckCards.removeAll()
        listOfCardsBeingPlayed.removeAll()
        selectedCards.removeAll()
        matchedCards.removeAll()
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
    func selectCard(at index: Int) {
        let selectedCard = listOfCardsBeingPlayed[index]
        if selectedCards.count < 3 {  // if there are 2 selected
            if selectedCards.contains(selectedCard) {
                selectedCards.remove(at: selectedCards.firstIndex(of: selectedCard) ?? 0) // deselect
            } else {
                selectedCards.append(selectedCard) // or border outline
                if selectedCards.count == 3 {
                    // check if cards match
                    if cardsMatch() {
                        for card in selectedCards {
                            matchedCards.append(card)
                            // TODO: detele from deck of cards and from cards being played
                        }
                        selectedCards.removeAll()
                    }
                }
            }
        }
    }


    // Set game logic for matching set
    private func cardsMatch() -> Bool {
        return true
    }

    // functionality #2: dealing three new cards


}


