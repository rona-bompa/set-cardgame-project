//
//  Set.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 25.02.2022.
//

import Foundation
import UIKit

enum Match {
    case yes
    case no
    case notYetThreeCards
}

class Set {

    var deckCards = [Card]()
    var listOfCardsBeingPlayed = [Card]()
    var selectedCards = [Card]()
    var matchedCards = [Card]()
    var matchColor: Match = Match.notYetThreeCards

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

    // MARK: functionality #1: selecting cards to match
    func selectCard(at index: Int) {
        let selectedCard = listOfCardsBeingPlayed[index]

        switch selectedCards.count {
        case 0:
            selectedCards.append(selectedCard)
            matchColor = Match.notYetThreeCards
        case 1:
            if !selectedCards.contains(selectedCard) {
                selectedCards.append(selectedCard)
                matchColor = Match.notYetThreeCards
            } else {
                selectedCards.remove(at: selectedCards.firstIndex(of: selectedCard)!)
            }
        case 2:
            if !selectedCards.contains(selectedCard) {
                selectedCards.append(selectedCard)
                if selectedCardsMatch() {
                    matchColor = Match.yes
                } else {
                    matchColor = Match.no
                }
            } else {
                selectedCards.remove(at: selectedCards.firstIndex(of: selectedCard)!)
            }
        case 3:
            if !selectedCards.contains(selectedCard) {
                if !selectedCardsMatch() {
                    // they don't match
                    selectedCards.removeAll()
                } else {
                    // they match -> replace cards
                    dealThreeMoreCards()
                    matchColor = Match.notYetThreeCards
                }
                matchColor = Match.notYetThreeCards
                selectedCards.append(selectedCard)
            }
        default: break
        }
    }

    // Game logic for matching sets
    // TODO: REAL GAME LOGIC
    private func selectedCardsMatch() -> Bool {
         // match var 1) same number of shapes
        if selectedCards[0].color == selectedCards[1].color &&
            selectedCards[1].color == selectedCards[2].color {
            return true
        } else {
            return false
        }
    }

    // MARK: functionality #2: dealing three new cards
    func dealThreeMoreCards() {
        if deckCards.count > 0 { // if there are cards in deck
            switch selectedCards.count {
            case 0...2:
                for _ in 0...2 { // add 3 more cards
                    let randomIndex = deckCards.count.arc4random
                    listOfCardsBeingPlayed.append(deckCards[randomIndex])
                    deckCards.remove(at: randomIndex)
                    selectedCards.removeAll()
                }
            case 3:
                if listOfCardsBeingPlayed.count > 0 {
                    if selectedCardsMatch() {
                        for card in selectedCards {
                            matchedCards.append(card) // append the matched cards
                            let randomIndex = deckCards.count.arc4random // index for random new card
                            let cardIndex = listOfCardsBeingPlayed.firstIndex(of: card) // the index card of the selected one
                            listOfCardsBeingPlayed[cardIndex!] = deckCards[randomIndex] // we
                            deckCards.remove(at: randomIndex) // remove from deck of cards
                        }
                        selectedCards.removeAll() // remove all selected cards
                    }
                }
            default: break
            }
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

// maybe another closure could be one with the index?
