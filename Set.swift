//
//  Set.swift
//  Set_Cardgame
//
//  Created by Rona Bompa on 25.02.2022.
//

import Foundation
import UIKit

// this enum is the only solution I could think of for the green/red bordering color after selected
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
    var areAMatch: Match = Match.notYetThreeCards
    var score = 0

    init() {
        newGame()
    }

    func newGame() {
        score = 0
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
        }

        for card in listOfCardsBeingPlayed {
            deckCards.remove(at: deckCards.firstIndex(of: card)!)
        }
    }

    // MARK: functionality #1: selecting cards to match
    func selectCard(at index: Int) {
        let selectedCard = listOfCardsBeingPlayed[index]

        switch selectedCards.count {
        case 0: // no cards selected
            selectedCards.append(selectedCard)
            areAMatch = Match.notYetThreeCards
        case 1: // 1 card already selected
            if !selectedCards.contains(selectedCard) {
                selectedCards.append(selectedCard)
            } else {
                selectedCards.remove(at: selectedCards.firstIndex(of: selectedCard)!)
                score -= 1
            }
            areAMatch = Match.notYetThreeCards
        case 2: // 2 cards already selected
            if !selectedCards.contains(selectedCard) {
                selectedCards.append(selectedCard)
                if selectedCardsMatch() {
                    areAMatch = Match.yes
                } else {
                    areAMatch = Match.no
                }
            } else {
                selectedCards.remove(at: selectedCards.firstIndex(of: selectedCard)!)
                score -= 1
                areAMatch = Match.notYetThreeCards
            }
        case 3: // 3 cards already selected
            if !selectedCards.contains(selectedCard) {
                if !selectedCardsMatch() {
                    // they don't match
                    score -= 5
                    selectedCards.removeAll()
                } else {
                    // they match -> replace cards
                    dealThreeMoreCards()
                }
                selectedCards.append(selectedCard)
                areAMatch = Match.notYetThreeCards
            }
        default: break
        }
    }
    // The game logic for a matching set is 3 cards where EACH of the 4 characteristics is either all the same or all different
    // TODO: REAL GAME LOGIC
    private func selectedCardsMatch() -> Bool {
        // ACTUAL GAME LOGIC
        var isSet = false
        if (selectedCards[0].color == selectedCards[1].color &&
            selectedCards[1].color == selectedCards[2].color) ||
            (selectedCards[0].color != selectedCards[1].color &&
             selectedCards[1].color != selectedCards[2].color &&
             selectedCards[0].color != selectedCards[2].color)
        {
            if (selectedCards[0].shapes == selectedCards[1].shapes &&
                selectedCards[1].shapes == selectedCards[2].shapes) ||
                (selectedCards[0].shapes != selectedCards[1].shapes &&
                 selectedCards[1].shapes != selectedCards[2].shapes &&
                 selectedCards[0].shapes != selectedCards[2].shapes)
            {
                if (selectedCards[0].filling == selectedCards[1].filling &&
                    selectedCards[1].filling == selectedCards[2].filling) ||
                    (selectedCards[0].filling != selectedCards[1].filling &&
                     selectedCards[1].filling != selectedCards[2].filling &&
                     selectedCards[0].filling != selectedCards[2].filling)
                {
                    if (selectedCards[0].numberOfShapes == selectedCards[1].numberOfShapes &&
                        selectedCards[1].numberOfShapes == selectedCards[2].numberOfShapes) ||
                        (selectedCards[0].numberOfShapes != selectedCards[1].numberOfShapes &&
                         selectedCards[1].numberOfShapes != selectedCards[2].numberOfShapes &&
                         selectedCards[0].numberOfShapes != selectedCards[2].numberOfShapes)
                    {
                        isSet = true
                    }
                }
            }
        }

         // MARK: test version of "game logic"
        /*
        if selectedCards[0].color == selectedCards[1].color &&
            selectedCards[1].color == selectedCards[2].color {
            isSet = true
        } else {
            isSet = false
        }
         */
        return isSet
    }

    // MARK: functionality #2: dealing three new cards
    func dealThreeMoreCards() {
        switch selectedCards.count {
        case 0...2:
            score -= selectedCards.count
            for _ in 0...2 { // add 3 more cards
                let randomIndex = deckCards.count.arc4random
                listOfCardsBeingPlayed.append(deckCards[randomIndex])
                deckCards.remove(at: randomIndex)
            }
        case 3:
            if selectedCardsMatch(){
                score += 3
                if listOfCardsBeingPlayed.count <= 12 && listOfCardsBeingPlayed.count > 0 { // if there are less than 12 cards
                        for card in selectedCards {
                            matchedCards.append(card) // append the matched cards
                            if deckCards.count > 0 { // if there are cards in deck, replace
                                let randomIndex = deckCards.count.arc4random // index for random new card
                                if let cardIndex = listOfCardsBeingPlayed.firstIndex(of: card) {
                                    listOfCardsBeingPlayed[cardIndex] = deckCards[randomIndex] // replace
                                }
                                deckCards.remove(at: randomIndex) // remove from deck of cards
                            } else { // just remove, don't replace
                                if let cardIndex = listOfCardsBeingPlayed.firstIndex(of: card) {
                                    listOfCardsBeingPlayed.remove(at: cardIndex)
                                }
                            }
                        }
                } else { // don't replace
                    for card in selectedCards {
                        matchedCards.append(card) // append the matched cards
                        if let cardIndex = listOfCardsBeingPlayed.firstIndex(of: card) {
                            listOfCardsBeingPlayed.remove(at: cardIndex)
                        }
                    }
                }
            } else {
                score -= 5
                for _ in 0...2 { // add 3 more cards
                    let randomIndex = deckCards.count.arc4random
                    listOfCardsBeingPlayed.append(deckCards[randomIndex])
                    deckCards.remove(at: randomIndex)
                }
            }
        default: break
        }
    selectedCards.removeAll()
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

// MARK: what about this extension?
//extension Array {
//    func removeCardAtIndex(element: Element) -> Array<Element> {
//        return self.remove(at: self.firstIndex(of: element))
//    }
//}

